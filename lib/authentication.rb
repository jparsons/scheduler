# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
# 
#   <% if logged_in? %>
#     Welcome <%=h current_user.username %>! Not you?
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
# 
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
# 
#   before_filter :login_required, :except => [:index, :show]
module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_user, :logged_in?, :redirect_to_target_or_default, :admin?, :confirmed?
    controller.filter_parameter_logging :password
  end
 
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
 
  def logged_in?
    current_user && (current_user.role == "administrator" || current_user.role == "confirmed")
  end
  def admin?
    logged_in? && current_user.role == "administrator"
  end
 
  def confirmed?
    logged_in? && (current_user.role == "administrator" || current_user.role == "confirmed")
  end
 
  def login_required
    unless logged_in?
      flash[:error] = "You must first log in or sign up before accessing this page."
      store_target_location
      redirect_to root_url
    end
  end
 
  def admin_required
    unless logged_in? && admin? 
      flash[:error] = "You must first log in or sign up before accessing this page."
      store_target_location
      redirect_to root_url
    end
  end
 
  def require_no_user
    if logged_in?
      flash[:error] = "You are currently logged in. How did you log in if you can't remember your password."
      redirect_to :back
    end
 
  end
 
  def redirect_to_target_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
 
  private
 
  def store_target_location
    session[:return_to] = request.request_uri
  end
end
