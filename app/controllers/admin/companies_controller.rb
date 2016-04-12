class Admin::CompaniesController < AdminController
  before_action :set_company, only: [:edit, :update, :destroy]

  def new
    @company = Company.new
  end

  def index
    @search = Company.search(params[:q])
    @companies = @search.result.by_created_at.page(params[:page]).per(50)
  end

  def edit
  end

  def create
    @company = Company.create(company_params)
    respond_with @company, location: admin_companies_path
  end

  def update
    @company.update(company_params)
    respond_with @company, location: admin_companies_path
  end

  def destroy
    @company.destroy
    respond_with @company, location: admin_companies_path
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name)
  end
end
