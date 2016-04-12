class BrowseController < ApplicationController
  def index
    if params[:lat].present? && params[:lng].present?
      @users = User.search '*', location: { near: [params[:lat], params[:lng]], within: '100km' },
                                page: params[:page], per_page: 10

    end
  end
end