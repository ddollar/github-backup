module GithubBackup
  class Repository
    attr_reader :sawyer_resource, :shell

    def initialize(sawyer_resource, opts = {})
      @sawyer_resource = sawyer_resource
      @shell = opts[:shell] || Shell.new
    end

    def backup(backup_root)
      full_backup_path = File.join(backup_root, backup_path)

      puts "Backing up #{ full_backup_path }"

      if File.exists?(full_backup_path)
        backup_repository_incremental(full_backup_path)
      else
        backup_repository_initial(full_backup_path)
      end
    end

    def clone_url
      sawyer_resource.ssh_url
    end

    def backup_path
      "#{ sawyer_resource.full_name }.git"
    end

    private

    def backup_repository_initial(path)
      shell.run("git clone --mirror -n #{ clone_url } #{ path }")
    end

    def backup_repository_incremental(path)
      FileUtils.cd(path) do
        shell.run('git remote update')
      end
    end
  end
end
