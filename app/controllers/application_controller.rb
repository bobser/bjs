class ApplicationController < ActionController::Base

  before_filter :authenticate_user!
  respond_to :json

  protect_from_forgery


end
