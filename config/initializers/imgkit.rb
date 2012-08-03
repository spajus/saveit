IMGKit.configure do |config|
  config.wkhtmltoimage = Rails.root.join('vendor/tools/wkhtmltoimage-0.10.0_rc2', 'wkhtmltoimage-amd64').to_s if ENV['RACK_ENV'] == 'production'
  config.default_options = {
      :quality => 60
  }
  config.default_format = :png
end