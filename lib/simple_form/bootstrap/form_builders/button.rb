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
end

SimpleForm::FormBuilder.class_eval do
  prepend SimpleForm::Bootstrap::FormBuilders::Button
end
