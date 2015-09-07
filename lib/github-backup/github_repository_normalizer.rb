module GithubBackup
  class GithubRepositoryNormalizer
    attr_reader :sawer_resource

    def initialize(sawer_resource)
      @sawer_resource = sawer_resource
    end

    def clone_url
      if gist?
        sawer_resource.git_pull_url
      else
        sawer_resource.ssh_url
      end
    end

    def backup_path
      if gist?
        "#{ sawer_resource.owner.login }/#{ sawer_resource.id }.git"
      else
        "#{ sawer_resource.full_name }.git"
      end
    end

    def gist?
      !sawer_resource.full_name
    end
  end
end
