require 'fileutils'
require 'octokit'
require 'pp'
require 'yaml'

module Github; end

class Github::Backup

  VERSION = "0.6.0"

  attr_reader :backup_root, :debug, :username, :client

  def initialize(username, backup_root, options = {})
    @username    = username
    @backup_root = backup_root
    @options     = options
    @debug       = false

    unless options.key?(:token)
      config = read_gitconfig
      if config.key?('github')
        options[:token] = config['github'].fetch('token', nil)
      end
    end

    if options[:token]
      @client = Octokit::Client.new(:access_token => options[:token])
    else
      @client = Octokit::Client.new
    end
  end

  def execute
    backup_all
  rescue Octokit::Unauthorized
    puts "Github API authentication failed."
    puts "Please add a [github] section to your ~/.gitconfig"
    puts "  See: http://github.com/guides/tell-git-your-user-name-and-email-address"
    puts "Or, use the arguments to authenticate with your username and API token."
  end

  private ######################################################################

  def backup_directory_for(repository)
    File.join(backup_root, repository.name) + '.git'
  end

  def backup_all
    FileUtils::mkdir_p(backup_root)
    repositories = find_repositories.sort_by { |r| r.name }
    repositories.each do |repository|
      puts "Backing up: #{repository.name}"
      backup_repository repository
    end
  end

  def find_repositories
    repos = []
    repos.concat(first_page)
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

  def first_page
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
      shell("git clone --mirror -n #{repository.clone_url}")
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

  def read_gitconfig
    config = {}
    group = nil

    return config unless File.exists?(gitconfig_path)

    File.foreach(gitconfig_path) do |line|
      line.strip!
      if line[0] != ?# && line =~ /\S/
        if line =~ /^\[(.*)\]$/
          group = $1
          config[group] ||= {}
        else
          key, value = line.split("=").map { |v| v.strip }
          config[group][key] = value
        end
      end
    end
    config
  end

  def gitconfig_path
    "#{ENV['HOME']}/.gitconfig"
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
