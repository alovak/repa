require 'ext/core'
require 'rand'
require 'will_paginate'

# load the base application config file
path = "#{RAILS_ROOT}/config/policy.yml"
Policy = YAML.load_file(path)

# module ActionView
  # module Helpers
    # module UrlHelper
      # def current_page?(options, excluding = {})
        # url_string = CGI.escapeHTML(url_for(options))
        # request = @controller.request

        # debugger
        # if url_string =~ /^\w+:\/\//
          # url_string == "#{request.protocol}#{request.host_with_port}#{request.request_uri}"
        # else
          # parameters = request.parameters

          # excluding.each do |key|
            # parameters.delete(key)
          # end

          # request_string = CGI.escapeHTML(url_for(parameters))
          # url_string == request_string
        # end
      # end  
    # end
  # end
# end
