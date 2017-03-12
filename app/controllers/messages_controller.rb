class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @messages = @room.messages

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @messages }
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
    #   redirect_to @room
    # else
    #   flash[:error] = "#{@message.errors.full_messages.to_sentence}"
    #   redirect_back fallback_location: room_path(@room)
    end

    respond_to do |format|
      format.html do
        if @message.persisted?
          redirect_to @room
        else
          flash[:error] = "#{@message.errors.full_messages.to_sentence}"
          redirect_back fallback_location: root_path        
        end
      end

      format.js
    end
  end

  private
    def message_params
      params.require(:message).permit(:username, :body)
    end
end
