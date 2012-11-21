class MessagesController < ApplicationController
  
  before_filter :find_garden, except: [:index]

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    @message.garden = @garden
    @message.sender = current_user
    @message.recipient = @garden.user

    UserMailer.message_email(@message).deliver

    if @message.save
      redirect_to @garden, notice: 'Message was sent.'
    else
      render action: "new"
    end
  end


  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
  
  private

  def find_garden
    @garden = Garden.find(params[:garden_id])
  end
end
