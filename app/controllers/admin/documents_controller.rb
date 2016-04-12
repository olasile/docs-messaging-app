class Admin::DocumentsController < AdminController
  before_action :set_document, only: [:edit, :update, :destroy]

  def index
    @documents = Document.search(params[:q].present? ? params[:q] : '*', 
                            order: { created_at: :desc }, 
                            page: params[:page], 
                            per_page: 10)
  end

  def destroy
    @document.destroy
    respond_with @document, location: admin_documents_path
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end
end
