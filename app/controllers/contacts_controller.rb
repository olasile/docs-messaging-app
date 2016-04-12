class ContactsController < ApplicationController
  def index
    @contacts = User.search(params[:q].present? ? params[:q] : '*', 
                            where: { id: current_user.contacts.map(&:id) },
                            order: { created_at: :desc }, 
                            page: params[:page], 
                            per_page: 10)

  end

  def new
    @user = User.new

    render 'new', layout: false
  end

  def create
    @user = User.invite_or_find(contact_params)
    
    if @user.present? && @user.valid?
      conversation = Conversation.new
      conversation.users << @user
      conversation.users << current_user
      conversation.save
    end
  end

  def destroy
    @contact = User.find(params[:id])
    @contact.conversations.joins(:users).where(users: { id: current_user.id}).destroy_all
  end

  def destroy_all
    @ids = params[:ids] || []
    current_user.conversations.joins(:users).where(users: { id: @ids}).destroy_all
  end

  private 

  def contact_params
    params.require(:user).permit(:first_name, :last_name, :email, :company, :category, :phone, :company_name, :zipcode)
  end
end