require_relative './repository'
module GithubBackup
  class Wiki < Repository
    def clone_url
      "https://github.com/#{ sawyer_resource.full_name }.wiki.git"
    end

    def backup_path
      "#{ sawyer_resource.full_name }.wiki.git"
    end
  end
end
