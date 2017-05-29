module FootballCli
  class Config < Thor
    desc 'api_token KEY', 'Set the global configuration for api_token'
    method_options update: :boolean
    def api_token(api_token)
      Configuration.write(api_token, :api_token, options)
    end
  end
end
