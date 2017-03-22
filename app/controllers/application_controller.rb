class ApplicationController < ActionController::Base
  def index
    flash[:alert] = "Cool"
  end
end
