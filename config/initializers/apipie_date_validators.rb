class DateValidator < Apipie::Validator::BaseValidator

  def initialize(param_description, argument)
    super(param_description)
    @type = argument
  end

  def validate(value)
    return false if value.blank?
    !!(value.to_s =~ /^(19|20)\d\d[-\.](0[1-9]|1[012])[-\.](0[1-9]|[12][0-9]|3[01])$/)
  end

  def self.build(param_description, argument, options, block)
    if argument == Date
      self.new(param_description, argument)
    end
  end

  def description
    "Must be #{@type} (yyyy-mm-dd)."
  end
end