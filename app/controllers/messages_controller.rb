class MessagesController < ApplicationController
  before_action :find_conversation

  def index
    @messages = @conversation.messages

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    @message = @conversation.messages.new

    @messages.each do |message|
      if !message.read
        message.read = true
        message.save
      end
    end
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation.id)
    end
  end

  def new
    @message = @conversation.messages.new
  end



  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end


# before_action :find_conversation!

#   def new
#     @message = current_user.messages.build
#   end


#  def create
#   @conversation ||= Conversation.create(author_id: current_user.id,
#                                         receiver_id: @receiver.id)
#   @message = current_user.messages.build(messages_params)
#   @message.conversation_id = @conversation.id
#   @message.save!

#   flash[:success] = "Your message was sent!"
#   redirect_to conversation_path(@conversation)
# end

#   private

#   def messages_params
#     params.require(:message).permit(:body)
#   end

#   def find_conversation!
#     @conversation = Conversation.find_by(id: params[:conversation_id])
#     redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
#   end
