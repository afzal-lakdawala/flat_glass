class ApplicationController < ActionController::Base
  
  include ApplicationHelper
  #SECURITY
  #protect_from_forgery
  
  #GEMS  
  #CALLBACKS
  before_filter :before_filter_set
  after_filter :after_filter_set
  
  #PRIVATE
  private

  def before_filter_set
    #ui attributes
    @is_breadcrumb_enabled = (current_user.blank? ) ? false : true
    
    #find objects
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    end
    
    #log_visit
    Core::Visit.log(request, current_user, @account)
    
    #Current user data setting from session to use in model
    if current_user.present?
      User.current = current_user 
    end
  end
  
  def after_filter_set
    #set_access_control_headers madhukaudantha.blogspot.in/2011/05/access-control-allow-origin-in-rails.html
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
      
end
