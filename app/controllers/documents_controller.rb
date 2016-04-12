class DocumentsController < ApplicationController

  def index
    @documents = current_user.documents
                             .search(params[:q].present? ? params[:q] : '*', 
                                     order: { created_at: :desc }, 
                                     page: params[:page], 
                                     per_page: 10)
  end

  def show
    @document = current_user.documents.find(params[:id])

    render 'show', layout: false
  end


  def upload
  end

  def new
    @document = current_user.documents.build
  
    render 'new', layout: false
  end

  def create
    @document = current_user.documents.create(document_params)
  end

  def destroy
    @document = current_user.documents.find(params[:id])
    @document.destroy
  end

  def destroy_all
    @ids = params[:ids]
    current_user.documents.where(id: @ids).destroy_all
  end

  private 

  def document_params
    params.require(:document).permit(:name, :description, :file_url)
  end
end