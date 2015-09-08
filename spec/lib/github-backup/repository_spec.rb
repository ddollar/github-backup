require File.expand_path('../../../spec_helper', __FILE__)

describe GithubBackup::Repository do

  describe '.new' do

    it 'accepts a sawyer::Resource' do
      repo = GithubBackup::Repository.new(sawyer_repo)
      repo.sawyer_resource.must_equal sawyer_repo
    end

    it 'creates a default GithubBackup::Shell instance' do
      repo = GithubBackup::Repository.new(sawyer_repo)
      repo.shell.must_be_instance_of GithubBackup::Shell
    end

  end

  describe '#shell' do

    it 'returns the shell instance' do
      shell = GithubBackup::Shell.new
      repo = GithubBackup::Repository.new(sawyer_repo, shell: shell)
      repo.shell.must_be_same_as shell
    end

  end

  describe '#backup' do

    it 'clones the repository if it has not yet been backed up' do
      cmd = 'git clone --mirror -n ' \
            'git@github.com:ddollar/github-backup.git ' \
            '/ddollar/github-backup.git'
      shell = Minitest::Mock.new
      shell.expect(:run, true, [cmd])

      FakeFS do
        repo = GithubBackup::Repository.new(sawyer_repo, shell: shell)
        repo.backup(Dir.pwd)
      end

      shell.verify
    end

    # TODO: This doesn't check that we change in to the backup_path before
    # executing `git remote update`
    it 'updates the repository if it has already been backed up' do
      shell = Minitest::Mock.new
      shell.expect(:run, true, ['git remote update'])

      FakeFS do
        repo = GithubBackup::Repository.new(sawyer_repo, shell: shell)
        FileUtils.mkdir_p(File.join(Dir.pwd, repo.backup_path))
        repo.backup(Dir.pwd)
      end

      shell.verify
    end

  end

  describe '#clone_url' do

    it 'returns the repository clone URL' do
      repo = GithubBackup::Repository.new(sawyer_repo)
      repo.clone_url.must_equal 'git@github.com:ddollar/github-backup.git'
    end

  end

  describe '#backup_path' do

    it 'returns the repository backup path' do
      repo = GithubBackup::Repository.new(sawyer_repo)
      repo.backup_path.must_equal 'ddollar/github-backup.git'
    end

  end

end
