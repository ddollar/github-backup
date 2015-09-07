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

    def backup_all
      make_backup_root
      repositories.each { |repository| repository.backup(config.backup_root) }
    end

    def repositories
      repo_collection.repos(username)
    end

    def repo_collection
      @repo_collection ||= GithubBackup::GithubRepositoryCollection.new(client)
    end

    def backup_directory_for(repository)
      File.join(config.backup_root, repository.backup_path)
    end

    def make_backup_root
      # TODO: Handle errors
      FileUtils.mkdir_p(config.backup_root)
    end
  end
end
