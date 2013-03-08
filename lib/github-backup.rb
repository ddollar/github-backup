require 'fileutils'
require 'octokit'
require 'pp'

module Github; end

class Github::Backup

  VERSION = "0.6.0"

  attr_reader :backup_root, :debug, :username, :client

  def initialize(username, backup_root, options = {})
    @username    = username
    @backup_root = backup_root
    @options     = options
    if (options[:token] && !options[:login])
      options[:login] = @username
    end
    @debug = false
    @client = Octokit::Client.new(:login => options[:login], :oauth_token => options[:token])
  end

  def execute
    backup_all
  rescue Octokit::Unauthorized => e
    puts "Github API authentication failed."
    puts "Please add a [github] section to your ~/.gitconfig"
    puts "  See: http://github.com/guides/tell-git-your-user-name-and-email-address"
    puts "Or, use the arguments to authenticate with your username and API token."
  end

  private ######################################################################

  def backup_directory_for(repository)
    File.join(backup_root, repository.name) + '.git'
  end

  def backup_all(options={})
    FileUtils::mkdir_p(backup_root)
    repositories = client.repos(username).sort_by { |r| r.name }
    repositories.each do |repository|
      puts "Backing up: #{repository.name}"
      backup_repository repository
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

  def shell(command)
    puts "EXECUTING: #{command}" if debug
    IO.popen(command, 'r') do |io|
      output = io.read
      puts "OUTPUT:" if debug
      puts output if debug
    end
  end

end
