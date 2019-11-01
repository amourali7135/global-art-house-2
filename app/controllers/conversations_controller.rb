class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    if Conversation.between(params[:author_id], params[:receiver_id]).present?
      @conversation = Conversation.between(params[:author_id], params[:receiver_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:author_id, :receiver_id)
  end


end


# before_action :set_conversation, except: [:index]
#   before_action :check_participating!, except: [:index]

#   def new
#     raise
#     redirect_to conversation_path(@conversation) and return if @conversation
#     @conversation = Conversation.new
#     @message = current_user.messages.build
#   end


#   def index
#     @conversations = Conversation.participating(current_user).order('updated_at DESC')
#   end


#   def show
#     @message = Message.new
#   end

#   private

#   def set_conversation
#     if params[:id]
#       @conversation = Conversation.find(params[:id])
#   end
# end

#   def check_participating!
#     # raise
#     redirect_to root_path unless @conversation && @conversation.participates?(current_user)
#   end

#   def find_conversation!
#     if params[:receiver_id]
#       @receiver = User.find_by(id: params[:receiver_id])
#       redirect_to(root_path) and return unless @receiver
#       @conversation = Conversation.between(current_user.id, @receiver.id)[0]
#     else
#       @conversation = Conversation.find_by(id: params[:conversation_id])
#       redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
#     end
#   end
