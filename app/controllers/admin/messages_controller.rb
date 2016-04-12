class Admin::MessagesController < AdminController
  before_action :set_conversation

  def index
    @messages = Message.search(params[:q].present? ? params[:q] : '*', 
                                     where: { conversation_id: @conversation.id },
                                     order: { created_at: :desc }, 
                                     page: params[:page], 
                                     per_page: 10)

  end

  def destroy
    @message = @conversation.messages.find(params[:id])
    @message.destroy

    respond_with @message, location: admin_conversation_messages_path(@conversation)
  end

  private 

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end