module SimpleForm::Bootstrap::FormBuilders::DateTime
  DATE_TIME_COLUMN_TYPES = [
    :datetime,
    'datetime',
    'timestamp',
    'timestamp without time zone'
  ].freeze

  DATE_COLUMN_TYPES = [
    :date,
    'date'
  ].freeze

  def default_input_type(attribute_name, column, options, *args, &block)
    if (options.is_a?(Hash) ? options[:as] : @options[:as]).nil? && !column.nil?
      type = column.respond_to?(:type) ? column.type : column.sql_type
      return :bootstrap_date_time if DATE_TIME_COLUMN_TYPES.include?(type)
      return :bootstrap_date if DATE_COLUMN_TYPES.include?(type)
    end

    super(attribute_name, column, options, *args, &block)
  end
end

SimpleForm::FormBuilder.class_eval do
  prepend SimpleForm::Bootstrap::FormBuilders::DateTime

  map_type :bootstrap_date_time, :bootstrap_date, to: SimpleForm::Bootstrap::Inputs::DateTimeInput
end
