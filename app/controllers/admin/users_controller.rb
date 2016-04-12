class Admin::UsersController < AdminController
  before_action :set_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
     @users = User.search(params[:q].present? ? params[:q] : '*', 
                            order: { created_at: :desc }, 
                            page: params[:page], 
                            per_page: 10)

  end

  def edit
  end

  def update
    @user.update(user_params)
    respond_with @user, location: admin_users_path
  end

  def destroy
    @user.destroy
    respond_with @user, location: admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:admin, :password, :password_confirmation, :email)
  end
end
