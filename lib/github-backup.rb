require 'octopi'
require 'pp'

module Github; end

class Github::Backup

  VERSION = "0.4.1"

  include Octopi

  attr_reader :backup_root, :debug, :username

  def initialize(username, backup_root)
    @username    = username
    @backup_root = backup_root
    @debug = false
  end

  def execute
    backup_all
    
  rescue Errno::ENOENT
    puts "Please install git and create a ~/.gitconfig"
    puts "  See: http://github.com/guides/tell-git-your-user-name-and-email-address"
  rescue NoMethodError
    puts "Please add a [github] section to your ~/.gitconfig"
    puts "  See: http://github.com/guides/tell-git-your-user-name-and-email-address"
  rescue Octopi::APIError => e
    # only handle "Authentication required" errors
    unless (e.message =~ /status 401$/)
      raise e
    end
    puts "Please add a [github] section to your ~/.gitconfig"
    puts "  See: http://github.com/guides/tell-git-your-user-name-and-email-address"
    puts "Or, authenticate with your username and API token."
    options = {}
    print "Username: "
    options[:login] = gets.chomp
    print "Token: "
    options[:token] = gets.chomp
    backup_all options
  end

private ######################################################################

  def github_authenticate(options={})
    if (options[:login])
      authenticated_with(options) do
        yield
      end
    else
      authenticated do
        yield
      end
    end
  end

  def backup_directory_for(repository)
    File.join(backup_root, repository.name)
  end

  def backup_all(options={})
    FileUtils::mkdir_p(backup_root)
    github_authenticate(options) do
      repositories = User.find(username).repositories.sort_by { |r| r.name }
      repositories.each do |repository|
        puts "Backing up: #{repository.name}"
        backup_repository repository
      end
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
      shell("git clone -n #{repository.clone_url}")
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
