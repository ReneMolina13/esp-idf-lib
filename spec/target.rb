# frozen_string_literal: true

require "yaml"

# A class that represents build target

class Target
  VALID_KEYS = %w[name].freeze

  def initialize(arg)
    validate_arg(arg)
    validate_keys(arg) if arg.is_a?(Hash)
    @metadata = if arg.is_a?(String)
                  { "name" => arg }
                else
                  arg
                end
  end

  attr_reader :metadata

  def valid_arg_class?(arg)
    arg.is_a?(String) || arg.is_a?(Hash)
  end

  def validate_arg(arg)
    raise ArgumentError, "String or dict is ecpected, but got `#{arg.class}`" unless valid_arg_class?(arg)
  end

  def validate_keys(hash)
    hash.each_key do |k|
      raise ArgumentError, "unknown key: `#{k}`. valid keys are: #{VALID_KEYS.join(' ')}" unless VALID_KEYS.include?(k)
    end
  end

  def name?
    metadata.key?("name")
  end

  def name
    metadata["name"]
  end
end
