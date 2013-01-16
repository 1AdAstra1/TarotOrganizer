class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  before_filter :instantiate_controller_and_action_names
   
  include DecksCommon 
  
  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
