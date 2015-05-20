module SimpleForm::Bootstrap::FormBuilders::Button
  # Adds the btn-default class selectively to buttons which do not have an explicit button type.
  def button(type, *args, &proc)
    options = args.extract_options!.dup
    options[:class] = [*options[:class]]

    # Add the specified class type.
    if options[:class].select { |cls| cls.length < 4 || cls[0, 4] == 'btn-' }.empty?
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
