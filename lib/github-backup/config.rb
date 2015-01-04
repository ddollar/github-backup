module GithubBackup
  class Config

    DEFAULTS = {
      :gitconfig_path => "#{ENV['HOME']}/.gitconfig",
    }

    attr_reader :backup_root, :gitconfig_path, :token

    def initialize(options = {})
      @backup_root    = options.fetch(:backup_root)    { raise ArgumentError, 'A backup_root option is required' }
      @gitconfig_path = options.fetch(:gitconfig_path) { DEFAULTS[:gitconfig_path] }
      @token          = options.fetch(:token)          { default_token }
    end

    private

    def default_token
      config = read_gitconfig
      if config.key?('github')
        config['github'].fetch('token', nil)
      end
    end

    def read_gitconfig
      config = {}
      group = nil

      return config unless File.exists?(gitconfig_path)

      File.foreach(gitconfig_path) do |line|
        line.strip!
        if line[0] != ?# && line =~ /\S/
          if line =~ /^\[(.*)\]$/
            group = $1
            config[group] ||= {}
          else
            key, value = line.split("=").map { |v| v.strip }
            config[group][key] = value
          end
        end
      end
      config
    end

  end
end
