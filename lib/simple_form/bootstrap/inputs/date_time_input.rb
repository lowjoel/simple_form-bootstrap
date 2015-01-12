# Inspired by this StackOverflow answer: http://stackoverflow.com/a/19018501
# I have modified this to work with dates AND times, and also to work better
# with browsers with JavaScript disabled.
class SimpleForm::Bootstrap::Inputs::DateTimeInput < SimpleForm::Inputs::Base
  def input(_ = nil)
    text_field_options             = input_html_options.with_indifferent_access
    format                         = text_field_options.delete(:format) || default_format

    # Integrate with Bootstrap's styling
    text_field_options[:class]    << 'form-control'

    hidden_field_options           = text_field_options.dup
    hidden_field_options[:class]   = text_field_options[:class].dup # so they won't work with same array object
    hidden_field_options[:id]      = "#{attribute_name}_hidden"
    hidden_field_options[:value] ||= value(object).try(:to_s)
    text_field_options[:class]    << 'bootstrap-datepicker'
    text_field_options[:class]    << 'bootstrap-timepicker' if input_type == :bootstrap_date_time
    text_field_options[:value]   ||= format_date(value(object), format)

    text_field_group_classes       = text_field_options[:class].dup
    text_field_group_classes.delete('form-control')

    return_string = <<-END_INPUT
      <div class="input-group #{text_field_group_classes.join(' ')}" style="display: none"
        data-date-format="#{strftime_to_momentjs_format(format)}">
        #{@builder.hidden_field(attribute_name, text_field_options.to_hash)}
        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
      </div>
      #{@builder.text_field(attribute_name, hidden_field_options.to_hash)}
    END_INPUT
    return_string.html_safe
  end

  protected

  # Gets the format suitable for this field.
  def default_format
    case input_type
      when :bootstrap_date
        I18n.t('date.formats.default')
      when :bootstrap_date_time
        I18n.t('time.formats.default')
    end
  end

  def value(object)
    object.send @attribute_name if object
  end

  def format_date(value, format)
    value.try(:strftime, format)
  end

  private

  # rubocop:disable Style/CyclomaticComplexity, Style/MethodLength
  def strftime_to_momentjs_format(format)
    format.gsub(/([^%]%|^%)([_\-\^][a-zA-Z]|[a-zA-Z])/i) do |match|
      last_match = Regexp.last_match(2)

      # Preprocess the last match:
      # - %_m is blank-padding
      # - %-m is no padding
      # - %^B is uppercase
      padding = 0 # zero padding; 1 = blank, 2 = none
      case last_match[0]
        when '_'
          padding = 1
          last_match = last_match[1]
        when '-'
          padding = 2
          last_match = last_match[1]
        when '^'
          last_match = last_match[1]
      end

      specifier =
        case last_match
          when 'a' # Abbreviated day
            'ddd'
          when 'A' # Full day
            'dddd'
          when 'd' # Day of month, with leading 0
            padding == 2 ? 'D' : 'DD'
          when 'u' # Day of year, with leading 0's (3 digits)
            'DDDD'
          when 'w' # Day of week, Sunday = 0
            'd'

          when 'b', 'h' # Abbreviated month
            'MMM'
          when 'B' # Full month
            'MMMM'
          when 'm' # Two digit representation of month (01 = Jan)
            padding == 2 ? 'M' : 'MM'

          when 'y' # Two digit representation of the year
            'YY'
          when 'Y' # Four digit representation of the year
            'YYYY'

          when 'H' # Two digit representation of the hour in 24-hour format
            'HH'
          when 'k' # Two digit representation of the hour in 24-hour format, padded with space
            'H'
          when 'I' # Two digit representation of the hour in 12-hour format
            'hh'
          when 'l' # Two digit representation of the hour in 12-hour format, padded with space
            'h'

          when 'M' # Two digit representation of minute
            'mm'
          when 'p' # Uppercase AM or PM
            'A'
          when 'P' # Lowercase AM or PM
            'a'
          when 'S' # Two digit representation of seconds
            'ss'

          when 'z' # The time zone offset. e.g. -0500
            'ZZ'
          when 'Z' # The time zone offset. e.g. EST
            'z'
          else
            match
        end

      # Strip the % and return the new specifier
      match = Regexp.last_match(1)
      (match.slice(0, match.length - 1) || '') + specifier
    end
  end
  # rubocop:enable Style/CyclomaticComplexity, Style/MethodLength
end
