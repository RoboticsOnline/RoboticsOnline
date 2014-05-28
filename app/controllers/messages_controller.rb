class MessagesController < ApplicationController
  before_action :set_message_id, only: [:showInbox, :showOutbox]
  before_action :set_message, only: [:inbox, :outbox]

  def index

  end

  def showInbox
  
  end

  def showOutbox
  
  end

  def new
    @message = Message.new
  end

  def ticket 
    @message = Message.new
  end
  def ticket_create
    Admin.all.each do |a| 
      @message = Message.new(message_params)
      @message.from_user = current_user.username
      @message.published_at = Time.now()
      @message.unread = true
      @message.to_user = User.find(a.user_id).username
      @message.save
    end
    redirect_to root_path
  end
 
  def new_reply
     @reply_message = Message.find(params[:id])
  end

  def inbox

  end

  def outbox

  end

  def reply
    m = Message.find(params[:id]) 
    @reply_message = Message.new(message_params)
    @reply_message.from_user = current_user.username
    @reply_message.to_user = m.from_user 
    @reply_message.published_at = Time.now()
    @reply_message.unread = true
    respond_to do |format|
      if @reply_message.save(message_params)
        format.html { render action: 'reply' }
      else
        format.html { render action: 'new_reply' }
      end
    end
  end

  def create
      @message = Message.new(message_params)
      @message.from_user = current_user.username
      @message.published_at = Time.now()
      @message.unread = true
      respond_to do |format|
        if @message.save(message_params)
          format.html { render action: 'create' }
        else
          format.html { render action: 'new' }
        end
      end
  end

  def page
    @page = params[:id].to_i

    @first_state_messages = Message.all.reverse!
    @second_state_messages = @first_state_messages
    @third_state_messages = @second_state_messages.last(@second_state_messages.count - (params[:id].to_i - 1)*2)

    @messages = @third_state_messages.first(2)
  end

  private
    def set_message_id
      @message = Message.find(params[:id])
    end

    def set_message
      @messages = Message.all.reverse!
      @page = 1
    end

    def message_params
      params.require(:message).permit(:from_user, :to_user, :title, :content, :published_at, :unread)
    end
end