class ContactsFilesController < ApplicationController
  def new
    render 'new', layout: false
  end

  def create
    @contacts_file = current_user.contacts_files.create(file_url: params[:file_url])
    @contacts = @contacts_file.create_contacts unless @contacts_file.new_record?
  end
end