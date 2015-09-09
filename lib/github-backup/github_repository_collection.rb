module GithubBackup
  class GithubRepositoryCollection
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def repos(username)
      first_page =
        if username_is_authenticated_user?(username)
          client.repos
        elsif username_is_organisation?(username)
          client.org_repos(username)
        else
          client.repos(username)
        end

      all(first_page).map { |r| GithubBackup::Repository.new(r) }
    end

    def gists(username)
      first_page =
        if username_is_authenticated_user?(username)
          client.gists
        else
          client.gists(username)
        end

      all(first_page).map { |r| GithubBackup::Gist.new(r) }
    end

    def starred_gists(username)
      first_page =
        if username_is_authenticated_user?(username)
          client.starred_gists
        else
          client.starred_gists(username)
        end

      all(first_page).map { |r| GithubBackup::Gist.new(r) }
    end

    def wikis(username)
      first_page =
        if username_is_authenticated_user?(username)
          client.repos
        elsif username_is_organisation?(username)
          client.org_repos(username)
        else
          client.repos(username)
        end

      all(first_page).
        select(&:has_wiki?).
          map { |r| GithubBackup::Wiki.new(r) }
    end

    private

    def all(first_page)
      repos = []
      repos.concat(first_page)

      # Iterate over paginated response
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

    def username_is_organisation?(username)
      client.user(username).type == 'Organization'
    end

    def username_is_authenticated_user?(username)
      return false unless client.token_authenticated?
      username == client.user.login
    end
  end
end
