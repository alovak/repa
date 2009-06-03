# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'ce621629c9b6e6842674f78342a14830'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  before_filter :authorize

  attr_reader :current_user
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
