module SimpleForm::Bootstrap::FormBuilders::Button
  BUTTON_CLASSES = ['btn-default', 'btn-primary', 'btn-success', 'btn-info', 'btn-warning',
                    'btn-danger', 'btn-link'].freeze

  # Adds the btn-default class selectively to buttons which do not have an explicit button type.
  def button(type, *args, &proc)
    options = args.extract_options!.dup
    options[:class] = [*options[:class]]

    # Add the specified class type.
    if options[:class].select { |cls| BUTTON_CLASSES.include?(cls) }.empty?
      if type.to_s == :submit.to_s.freeze
        options[:class] << 'btn-primary'
      else
        options[:class] << 'btn-default'
      end
    end
    args << options

    super(type, *args, &proc)
  end

  # Creates a submit button.
  #
  # This augments the original button implementation to generate a button element
  # with a submit action when a block is given. Otherwise, it falls back to the
  # original submit helper.
  def submit_button(*args, &block)
    if block_given?
      options = args.extract_options!.dup
      options[:type] = :submit
      options[:name] ||= 'commit'
      args << options
      button_button(options, &block)
    else
      submit(*args)
    end
  end

end

SimpleForm::FormBuilder.class_eval do
  prepend SimpleForm::Bootstrap::FormBuilders::Button
end
