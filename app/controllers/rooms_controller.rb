class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def create
    @room = Room.new room_params
    if @room.save
      flash[:success] = 'Created room successfully'
      redirect_to @room
    else
      flash[:error] = "#{@room.errors.full_messages.to_sentence}"
      redirect_back fallback_location: root_path
    end
  end

  private
    def room_params
      params.require(:room).permit(:name)
    end
end
