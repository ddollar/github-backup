require File.expand_path('../../../spec_helper', __FILE__)

describe GithubBackup::Repository do

  describe '.new' do

    it 'requires a clone_url' do
      args = { backup_path: '/tmp/github-backup/ddollar/github-backup.git' }
      proc { GithubBackup::Repository.new(args) }.must_raise KeyError
    end

    it 'requires a backup_path' do
      args = { clone_url: 'git@github.com:ddollar/github-backup.git' }
      proc { GithubBackup::Repository.new(args) }.must_raise KeyError
    end

    it 'creates a default GithubBackup::Shell instance' do
      args = { clone_url: 'git@github.com:ddollar/github-backup.git',
               backup_path: '/tmp/github-backup/ddollar/github-backup.git' }
      repo = GithubBackup::Repository.new(args)
      repo.shell.must_be_instance_of GithubBackup::Shell
    end
  end

  describe '#clone_url' do

    it 'returns the repository clone URL' do
      args = { clone_url: 'git@github.com:ddollar/github-backup.git',
               backup_path: '/tmp/github-backup/ddollar/github-backup.git' }
      repo = GithubBackup::Repository.new(args)
      repo.clone_url.must_equal 'git@github.com:ddollar/github-backup.git'
    end

  end

  describe '#backup_path' do

    it 'returns the repository backup path' do
      args = { clone_url: 'git@github.com:ddollar/github-backup.git',
               backup_path: '/tmp/github-backup/ddollar/github-backup.git' }
      repo = GithubBackup::Repository.new(args)
      repo.backup_path.must_equal '/tmp/github-backup/ddollar/github-backup.git'
    end

  end

  describe '#shell' do

    it 'returns the shell instance' do
      shell = GithubBackup::Shell.new
      args = { clone_url: 'git@github.com:ddollar/github-backup.git',
               backup_path: '/tmp/github-backup/ddollar/github-backup.git',
               shell: shell }
      repo = GithubBackup::Repository.new(args)
      repo.shell.must_be_same_as shell
    end

  end

  describe '#backup' do

    it 'clones the repository if it has not yet been backed up' do
      cmd = 'git clone --mirror -n ' \
            'git@github.com:ddollar/github-backup.git ' \
            '/tmp/github-backup/ddollar/github-backup.git'
      shell = Minitest::Mock.new
      shell.expect(:run, true, [cmd])

      args = { clone_url: 'git@github.com:ddollar/github-backup.git',
               backup_path: '/tmp/github-backup/ddollar/github-backup.git',
               shell: shell }

      FakeFS do
        repo = GithubBackup::Repository.new(args)
        repo.backup
      end

      shell.verify
    end

    # TODO: This doesn't check that we change in to the backup_path before
    # executing `git remote update`
    it 'updates the repository if it has already been backed up' do
      shell = Minitest::Mock.new
      shell.expect(:run, true, ['git remote update'])

      args = { clone_url: 'git@github.com:ddollar/github-backup.git',
               backup_path: '/tmp/github-backup/ddollar/github-backup.git',
               shell: shell }

      FakeFS do
        FileUtils.mkdir_p(args[:backup_path])
        repo = GithubBackup::Repository.new(args)
        repo.backup
      end

      shell.verify
    end

  end

end
