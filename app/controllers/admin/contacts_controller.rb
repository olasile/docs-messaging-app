class Admin::ContactsController < AdminController
  before_action :set_user

  def index
    @contacts = User.search(params[:q].present? ? params[:q] : '*', 
                            where: { id: @user.contacts.map(&:id) },
                            order: { created_at: :desc }, 
                            page: params[:page], 
                            per_page: 10)


  end

  def destroy
    @contact = User.find(params[:id])
    @contact.conversations.joins(:users).where(users: { id: @user.id}).destroy_all
    
    respond_with @contact, location: admin_user_contacts_path(@user)
  end

  private 

  def set_user
    @user = User.find(params[:user_id])
  end
end