module SimpleForm::Bootstrap::FormBuilders
  extend ActiveSupport::Autoload

  def self.load!
    Dir.glob("#{__dir__}/form_builders/*") do |path|
      require path
    end
  end
end
