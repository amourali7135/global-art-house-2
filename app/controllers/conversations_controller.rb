class ConversationsController < ApplicationController
  before_action :set_conversation, except: [:index]
  before_action :check_participating!, except: [:index]

  def new
    redirect_to conversation_path(@conversation) and return if @conversation
    @message = current_user.messages.build
  end


  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
  end


  def show
    @message = Message.new
  end

  private

  def set_conversation
    if request.referrer.include?('conversations')
      last_part = request.referrer.split('/').last
      if last_part.match? /\d+/
        last_link = request.referrer.split('/').last
      end
    end
    # raise
    if last_link
      @conversation = Conversation.find_by(author: current_user, receiver: Artist.find(last_link.to_i))
      if params[:receiver_id] && !params[:id]
        @conversation = Conversation.create(author: current_user, receiver: Artist.find(params[:receiver_id]).user)
      end
    end

    if params[:id]
      @conversation = Conversation.find(params[:id])
    end
  end

  def check_participating!
    # raise
    redirect_to root_path unless @conversation && @conversation.participates?(current_user)
  end

  def find_conversation!
    if params[:receiver_id]
      @receiver = User.find_by(id: params[:receiver_id])
      redirect_to(root_path) and return unless @receiver
      @conversation = Conversation.between(current_user.id, @receiver.id)[0]
    else
      @conversation = Conversation.find_by(id: params[:conversation_id])
      redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
    end
  end

end




