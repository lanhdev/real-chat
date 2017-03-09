class HomeController < ApplicationController
  def index
    @rooms = Room.all
    @room = Room.new
    @room.messages.build
  end

  def signin
    session[:username] = params[:username].presence
    redirect_back fallback_location: root_path
  end

  def signout
    session[:username] = nil
    redirect_back fallback_location: root_path
  end
end
