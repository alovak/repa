# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  before_filter :authorize

  attr_accessor :current_user
  private
  def authorize
    @current_user = User.find_by_id(session[:user_id])
    unless @current_user 
      session[:original_uri] = request.request_uri
      flash[:notice] = 'Пожалуйста, пройдите авторизацию'
      redirect_to :controller => :users, :action => :login
    end
  end
end
