module GithubBackup
  class Backup
    attr_reader :debug, :username, :client, :config

    def initialize(username, options = {})
      @username    = username
      @debug       = false
      @config      = Config.new(options)
      @client      = Octokit::Client.new(:access_token => config.token)
    end

    def execute
      backup_all
    rescue Octokit::Unauthorized
      puts "Github API authentication failed."
      puts "Please add a [github] section to your ~/.gitconfig"
      puts "  See: http://github.com/guides/tell-git-your-user-name-and-email-address"
      puts "Or, use the arguments to authenticate with your username and API token."
    end

    private

    def backup_root
      config.backup_root
    end

    def backup_directory_for(repository)
      File.join(backup_root, repository.full_name) + '.git'
    end

    def backup_all
      FileUtils::mkdir_p(backup_root)
      repositories.each do |repository|
        puts "Backing up: #{repository.full_name}"
        backup_repository repository
      end
    end

    def repositories
      repos = []
      repos.concat(get_repositories_first_page)

      # Iterate over paginated response
      last_response = client.last_response
      unless last_response.rels[:next].nil?
        loop do
          last_response = last_response.rels[:next].get
          repos.concat(last_response.data)
          break if last_response.rels[:next].nil?
        end
      end

      repos
    end

    def get_repositories_first_page
      if username_is_authenticated_user?
        client.repos
      elsif username_is_organisation?
        client.org_repos(username)
      else
        client.repos(username)
      end
    end

    def backup_repository(repository)
      if File.exists?(backup_directory_for(repository))
        backup_repository_incremental(repository)
      else
        backup_repository_initial(repository)
      end
    end

    def backup_repository_initial(repository)
      FileUtils::cd(backup_root) do
        shell("git clone --mirror -n #{repository.clone_url} #{repository.full_name}.git")
      end
    end

    def backup_repository_incremental(repository)
      FileUtils::cd(backup_directory_for(repository)) do
        shell("git remote update")
      end
    end

    def username_is_organisation?
      client.user(username).type == 'Organization'
    end

    def username_is_authenticated_user?
      return false unless client.token_authenticated?
      username == client.user.login
    end

    def shell(command)
      puts "EXECUTING: #{command}" if debug
      IO.popen(command, 'r') do |io|
        output = io.read
        puts "OUTPUT:" if debug
        puts output if debug
      end
    end
  end
end
