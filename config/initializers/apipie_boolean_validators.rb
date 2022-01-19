class BooleanValidator < Apipie::Validator::BaseValidator

  def validate(value)
    %w[true false].include?(value.to_s)
  end

  def self.build(param_description, argument, options, block)
    if argument == :bool
      self.new(param_description)
    end
  end

  def description
    "Must be 'true' or 'false'"
  end
end