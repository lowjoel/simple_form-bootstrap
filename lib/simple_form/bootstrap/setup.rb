# Handles configuration Simple Form with Bootstrap defaults.
module SimpleForm::Bootstrap::Setup
  def setup
    super do |config|
      yield config
      configure_simple_form(config)
    end
  end

  private

  def configure_simple_form(config)
    config.error_notification_tag = :div
    config.error_notification_class = 'alert alert-danger'
    config.button_class = 'btn'
    config.boolean_style = :nested
    config.boolean_label_class = nil

    configure_wrappers(config)

    # Wrappers for forms and inputs using the Bootstrap toolkit.
    # Check the Bootstrap docs (http://getbootstrap.com)
    # to learn about the different styles for forms and inputs,
    # buttons and other elements.
    config.default_wrapper = :vertical_form
    config.wrapper_mappings = {
      check_boxes: :vertical_radio_and_checkboxes,
      radio_buttons: :vertical_radio_and_checkboxes,
      file: :vertical_file_input,
      boolean: :vertical_boolean,
    }
  end

  def configure_wrappers(config)
    configure_vertical_form_wrapper(config)
    configure_vertical_file_input_wrapper(config)
    configure_vertical_boolean_wrapper(config)
    configure_vertical_radio_and_checkboxes_wrapper(config)
    configure_horizontal_form_wrapper(config)
    configure_horizontal_file_input_wrapper(config)
    configure_horizontal_boolean_wrapper(config)
    configure_horizontal_radio_and_checkboxes_wrapper(config)
    configure_inline_form_wrapper(config)
  end

  def configure_vertical_form_wrapper(config)
    config.wrappers :vertical_form, tag: 'div', class: 'form-group',
                    error_class: 'has-error' do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :pattern
      b.optional :min_max
      b.optional :readonly
      b.use :label, class: 'control-label'

      b.use :input, class: 'form-control'
      b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  def configure_vertical_file_input_wrapper(config)
    config.wrappers :vertical_file_input, tag: 'div', class: 'form-group',
                    error_class: 'has-error' do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :readonly
      b.use :label, class: 'control-label'

      b.use :input
      b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  def configure_vertical_boolean_wrapper(config)
    config.wrappers :vertical_boolean, tag: 'div', class: 'form-group',
                    error_class: 'has-error' do |b|
      b.use :html5
      b.optional :readonly

      b.wrapper tag: 'div', class: 'checkbox' do |ba|
        ba.use :label_input
      end

      b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  def configure_vertical_radio_and_checkboxes_wrapper(config)
    config.wrappers :vertical_radio_and_checkboxes, tag: 'div', class: 'form-group',
                    error_class: 'has-error' do |b|
      b.use :html5
      b.optional :readonly
      b.use :label, class: 'control-label'
      b.use :input
      b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  def configure_horizontal_form_wrapper(config)
    config.wrappers :horizontal_form, tag: 'div', class: 'form-group',
                    error_class: 'has-error' do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :pattern
      b.optional :min_max
      b.optional :readonly
      b.use :label, class: 'col-sm-3 control-label'

      b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
        ba.use :input, class: 'form-control'
        ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
        ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
      end
    end
  end

  def configure_horizontal_file_input_wrapper(config)
    config.wrappers :horizontal_file_input, tag: 'div', class: 'form-group',
                    error_class: 'has-error' do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :readonly
      b.use :label, class: 'col-sm-3 control-label'

      b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
        ba.use :input
        ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
        ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
      end
    end
  end

  def configure_horizontal_boolean_wrapper(config)
    config.wrappers :horizontal_boolean, tag: 'div', class: 'form-group',
                    error_class: 'has-error' do |b|
      b.use :html5
      b.optional :readonly

      b.wrapper tag: 'div', class: 'col-sm-offset-3 col-sm-9' do |wr|
        wr.wrapper tag: 'div', class: 'checkbox' do |ba|
          ba.use :label_input, class: 'col-sm-9'
        end

        wr.use :error, wrap_with: { tag: 'span', class: 'help-block' }
        wr.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
      end
    end
  end

  def configure_horizontal_radio_and_checkboxes_wrapper(config)
    config.wrappers :horizontal_radio_and_checkboxes, tag: 'div', class: 'form-group',
                    error_class: 'has-error' do |b|
      b.use :html5
      b.optional :readonly

      b.use :label, class: 'col-sm-3 control-label'

      b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
        ba.use :input
        ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
        ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
      end
    end
  end

  def configure_inline_form_wrapper(config)
    config.wrappers :inline_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :pattern
      b.optional :min_max
      b.optional :readonly
      b.use :label, class: 'sr-only'

      b.use :input, class: 'form-control'
      b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end
end
