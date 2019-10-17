class MessagesController < ApplicationController
  before_action :find_conversation!

  def new
    @message = current_user.messages.build
  end


 def create
  @conversation ||= Conversation.create(author_id: current_user.id,
                                        receiver_id: @receiver.id)
  @message = current_user.messages.build(messages_params)
  @message.conversation_id = @conversation.id
  @message.save!

  flash[:success] = "Your message was sent!"
  redirect_to conversation_path(@conversation)
end

  private

  def messages_params
    params.require(:message).permit(:body)
  end

  def find_conversation!
    @conversation = Conversation.find_by(id: params[:conversation_id])
    redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
  end
end
