# -*- coding: utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  layout 'common'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password
  before_filter :authorize

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  private
  def authorize
    unless current_user
      session[:original_uri] = request.request_uri
      flash[:notice] = 'Пожалуйста, пройдите авторизацию'
      redirect_to :controller => :users, :action => :login
    end
  end
end
