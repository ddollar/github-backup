module GithubBackup
  class Repository
    attr_reader :clone_url, :backup_path, :shell

    def initialize(opts = {})
      @clone_url = opts.fetch(:clone_url)
      @backup_path = opts.fetch(:backup_path)
      @shell = opts[:shell] || Shell.new
    end

    def backup
      if File.exists?(backup_path)
        backup_repository_incremental
      else
        backup_repository_initial
      end
    end

    private

    def backup_repository_initial
      shell.run("git clone --mirror -n #{ clone_url } #{ backup_path }")
    end

    def backup_repository_incremental
      FileUtils.cd(backup_path) do
        shell.run('git remote update')
      end
    end
  end
end
