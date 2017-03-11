class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @messages = @room.messages

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST rooms/:room_id/messages
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build message_params
    if @message.save
      unless current_user
        session[:username] = @message.username
      end
      redirect_to @room
    else
      flash[:error] = "#{@message.errors.full_messages.to_sentence}"
      redirect_back fallback_location: room_path(@room)
    end
  end

  private
    def message_params
      params.require(:message).permit(:username, :body)
    end
end
