require_relative './repository'
module GithubBackup
  class Gist < Repository
    def clone_url
      sawyer_resource.git_pull_url
    end

    def backup_path
      if sawyer_resource.owner
        "#{ sawyer_resource.owner.login }/#{ sawyer_resource.id }.git"
      else
        "anonymous/#{ sawyer_resource.id }.git"
      end
    end
  end
end
