SETTINGS = YAML.load_file("#{RAILS_ROOT}/config/settings.yml")[RAILS_ENV].deep_symbolize_keys

ActionMailer::Base.default_url_options[:host] = SETTINGS[:project][:host]
ActionMailer::Base.default_url_options[:protocol] = SETTINGS[:project][:protocol]

