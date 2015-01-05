require File.expand_path('../../../spec_helper', __FILE__)

describe GithubBackup::Backup do

  describe :new do

    # username
    it 'requires a username' do
      proc { GithubBackup::Backup.new }.
        must_raise ArgumentError
    end

    it 'initializes an Octokit client' do
      backup = GithubBackup::Backup.new('ddollar', :backup_root => '/tmp')
      backup.client.must_be_instance_of ::Octokit::Client
    end

    it 'configures the backup' do
      skip('Define GithubBackup::Config#==')

      opts = { :backup_root => '/tmp', :token => 'S3CR3T' }
      config = GithubBackup::Config.new(opts)
      backup = GithubBackup::Backup.new('ddollar', opts)
      backup.config.must_equal config
    end

    # :token
    describe 'with a token' do

      it 'will configure the client with an OAuth access token' do
        opts = { :backup_root => '/tmp', :token => 'S3CR3T' }
        backup = GithubBackup::Backup.new('ddollar', opts)
        backup.client.access_token.must_equal opts[:token]
      end
      
    end

    describe 'without a token' do

      it 'will not configure the client with an OAuth access token' do
        opts = { :backup_root => '/tmp' }
        backup = GithubBackup::Backup.new('ddollar', opts)
        backup.client.access_token.must_be_nil
      end
    
    end

  end

  describe :username do

    it 'returns the username of the GitHub account to back up' do
      backup = GithubBackup::Backup.new('ddollar', :backup_root => '/tmp')
      backup.username.must_equal 'ddollar'
    end

  end

  describe :client do

    it 'returns the Octokit client' do
      backup = GithubBackup::Backup.new('ddollar', :backup_root => '/tmp')
      backup.client.must_be_instance_of ::Octokit::Client
    end

  end

  describe :config do

    it 'returns the backup configuration' do
      backup = GithubBackup::Backup.new('ddollar', :backup_root => '/tmp')
      backup.config.must_be_instance_of GithubBackup::Config
    end

  end

  describe :debug do

    it 'returns false' do
      backup = GithubBackup::Backup.new('ddollar', :backup_root => '/tmp')
      backup.debug.must_equal false
    end

  end

end
