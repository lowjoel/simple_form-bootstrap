module SimpleForm::Bootstrap::FormBuilders::DateTime
  DATE_TIME_COLUMN_TYPES = [
    'datetime',
    'timestamp',
    'timestamp without time zone'
  ].freeze

  DATE_COLUMN_TYPES = [
    'date'
  ].freeze

  def default_input_type_with_bootstrap_date_time(attribute_name, column, options, *args, &block)
    if (options.is_a?(Hash) ? options[:as] : @options[:as]).nil? && !column.nil?
      return :bootstrap_date_time if DATE_TIME_COLUMN_TYPES.include?(column.sql_type)
      return :bootstrap_date if DATE_COLUMN_TYPES.include?(column.sql_type)
    end

    default_input_type_without_bootstrap_date_time(attribute_name, column, options, *args, &block)
  end
end

SimpleForm::FormBuilder.class_eval do
  include SimpleForm::Bootstrap::FormBuilders::DateTime

  map_type :bootstrap_date_time, :bootstrap_date, to: SimpleForm::Bootstrap::Inputs::DateTimeInput
  alias_method_chain :default_input_type, :bootstrap_date_time
end
