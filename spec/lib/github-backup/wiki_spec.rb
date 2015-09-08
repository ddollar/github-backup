require File.expand_path('../../../spec_helper', __FILE__)

describe GithubBackup::Wiki do

  it 'acts lie a Repository' do
    GithubBackup::Wiki.new(sawyer_repo).
      must_be_kind_of GithubBackup::Repository
  end

  describe '#clone_url' do

    it 'returns the repository clone URL' do
      repo = GithubBackup::Wiki.new(sawyer_repo)
      repo.clone_url.must_equal 'https://github.com/ddollar/github-backup.wiki.git'
    end

  end

  describe '#backup_path' do

    it 'returns the repository backup path' do
      repo = GithubBackup::Wiki.new(sawyer_repo)
      repo.backup_path.must_equal 'ddollar/github-backup.wiki.git'
    end

  end

end
