require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :authenticate_user!
  before_action :set_gon
  protect_from_forgery with: :exception

  def set_default_for_query_param
    params[:q] = '*' unless params[:q].present?
  end

  def set_gon
    gon.redis_url = ENV['REDISTOGO_URL']
  end
end
