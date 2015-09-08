require File.expand_path('../../../spec_helper', __FILE__)

describe GithubBackup::Gist do

  it 'acts lie a Repository' do
    GithubBackup::Gist.new(sawyer_anonymous_gist).
      must_be_kind_of GithubBackup::Repository
  end

  describe '#clone_url' do

    it 'returns the repository clone URL' do
      repo = GithubBackup::Gist.new(sawyer_anonymous_gist)
      repo.clone_url.must_equal 'https://gist.github.com/380919418d982afbc4fc.git'
    end

  end

  describe '#backup_path' do

    describe 'an anonymous gist' do

      it 'returns the repository backup path' do
        repo = GithubBackup::Gist.new(sawyer_anonymous_gist)
        repo.backup_path.must_equal 'anonymous/380919418d982afbc4fc.git'
      end

    end

    describe 'a public gist' do

      it 'returns the repository backup path' do
        repo = GithubBackup::Gist.new(sawyer_public_gist)
        repo.backup_path.must_equal 'garethrees/dae4757f11749b6edaf2.git'
      end

    end

  end

end
