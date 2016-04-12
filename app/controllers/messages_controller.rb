class MessagesController < ApplicationController
  before_action :set_conversation
  
  def index
    if params[:q].present?
      @messages = @conversation.messages
                               .search(params[:q].present? ? params[:q] : '*', 
                                       where: { conversation_id: @conversation.id },
                                       order: { created_at: :desc }, 
                                       page: params[:page], 
                                       per_page: 10)
    else
      @messages = @conversation.messages.by_created_at.page(params[:page]).per(10)
    end
    
    render 'index', layout: false
  end

  def create
    @message = current_user.messages.create(message_params)
  end

  private 

  def set_conversation
    @conversation = current_user.conversations.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body).merge(conversation_id: @conversation.id)
  end
end