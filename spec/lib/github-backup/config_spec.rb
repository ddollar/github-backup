require File.expand_path('../../../spec_helper', __FILE__)

describe GithubBackup::Config do

  describe :new do

    # :backup_root
    it 'requires a backup_root option' do
      proc { GithubBackup::Config.new() }.
        must_raise ArgumentError, 'A backup_root option is required'
    end

    it 'sets the backup_root through an option' do
      config = GithubBackup::Config.new(:backup_root => '/tmp')
      config.backup_root.must_equal '/tmp'
    end

    # :gitconfig_path
    it 'sets the default .gitconfig file path' do
      env = ENV.to_hash.merge("HOME" => "/home/ruby")
      Object.stub_const(:ENV, env) do
        config = GithubBackup::Config.new(:backup_root => '/tmp')
        config.gitconfig_path.must_equal '/home/ruby/.gitconfig'
      end
    end

    it 'sets a .gitconfig path through an option' do
      config = GithubBackup::Config.new(:backup_root => '/tmp',
                                        :gitconfig_path => '/tmp/.gitconfig')
      config.gitconfig_path.must_equal '/tmp/.gitconfig'
    end

    # :token
    it 'sets a default value of nil for the GitHub OAuth token option' do
      config = GithubBackup::Config.new(:backup_root => '/tmp')
      config.token.must_be_nil
    end

    it 'sets the GitHub OAuth token from an option key' do
      config = GithubBackup::Config.new(:backup_root => '/tmp',
                                        :token => 'S3CR3T')
      config.token.must_equal 'S3CR3T'
    end

    it 'sets the GitHub OAuth token from .gitconfig' do
      gitconfig_path = File.expand_path('../../../fixtures/gitconfig', __FILE__)
      config = GithubBackup::Config.new(:backup_root => '/tmp',
                                        :gitconfig_path => gitconfig_path)
      config.token.must_equal 'SUPER_S3CR3T'
    end

    describe 'attributes' do

      let(:config) do
        GithubBackup::Config.new(:backup_root => '/tmp/backup',
                                 :gitconfig_path => '/tmp/gitconfig',
                                 :token => 'S3CR3T')
      end

      describe :backup_root do

        it 'returns the directory where the repositories will be backed up' do
          config.backup_root.must_equal '/tmp/backup'
        end

      end

      describe :gitconfig_path do

        it 'returns the path to a gitconfig file' do
          config.gitconfig_path.must_equal '/tmp/gitconfig'
        end

      end

      describe :token do

        it 'returns the GitHub OAuth access token' do
          config.token.must_equal 'S3CR3T'
        end

      end

    end

    describe :== do

      it 'is equal if its attributes are identical' do
        opts = { :backup_root => '/tmp/backup',
                 :gitconfig_path => '/tmp/gitconfig',
                 :token => 'S3CR3T'}
        backup = GithubBackup::Config.new(opts)
        backup.dup.must_equal backup
      end

      it 'is not equal if any of the attributes vary' do
        opts = { :backup_root => '/tmp/backup',
                 :gitconfig_path => '/tmp/gitconfig',
                 :token => 'S3CR3T'}
        backup1 = GithubBackup::Config.new(opts)
        backup2 = GithubBackup::Config.new(opts.merge(:token => 'PASSWORD'))
        backup1.wont_equal backup2
      end

    end

  end
end
