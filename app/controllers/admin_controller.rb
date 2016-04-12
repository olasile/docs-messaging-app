require "application_responder"

class AdminController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  
  layout 'admin'

  before_filter do
    redirect_to new_user_session_path unless current_user && current_user.admin?
  end
end
