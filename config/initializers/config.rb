Config.setup do |config|
  # Name of the constant exposing loaded settings
  config.const_name = 'Settings'

  # Load environment variables from the `ENV` object and override any settings defined in files.
  config.use_env = true

  # Define ENV variable prefix deciding which variables to load into config.
  config.env_prefix = 'Settings'

  # Ability to process variables names:
  #   * nil  - no change
  #   * :downcase - convert to lower case
  #
  # config.env_converter = nil

  # Parse numeric values as integers instead of strings.
  # config.env_parse_values = false
end
