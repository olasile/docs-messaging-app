class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.search(params[:q].present? ? params[:q] : '*', 
                                     where: { user_ids: current_user.id },
                                     order: { updated_at: :desc }, 
                                     page: params[:page], 
                                     per_page: 10)

  end

  def new
    @conversation = current_user.conversations.build
  
    render 'new', layout: false
  end

  def create
    @conversation = current_user.conversations.create(conversations_params)
    @messages = @conversation.messages
  end

  def destroy
    @conversation = current_user.conversations.find(params[:id])
    @conversation.destroy
  end

  def destroy_all
    @ids = params[:ids]
    current_user.conversations.where(id: @ids).destroy_all
  end

  private 

  def conversations_params
    params.require(:conversation).permit(user_ids: [])
  end
end