class Admin::ConversationsController < AdminController
  before_action :set_user

  def index
    @conversations = Conversation.search(params[:q].present? ? params[:q] : '*', 
                                     where: { user_ids: @user.id },
                                     order: { updated_at: :desc }, 
                                     page: params[:page], 
                                     per_page: 10)

  end

  def destroy
    @conversation = @user.conversations.find(params[:id])
    @conversation.destroy

    respond_with @conversation, location: admin_user_conversations_path(@user)
  end

  private 

  def set_user
    @user = User.find(params[:user_id])
  end
end