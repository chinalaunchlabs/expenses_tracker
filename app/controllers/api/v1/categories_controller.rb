class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_user!

  def index
    @categories = Category.all

    render 'api/v1/categories'
  end
end
