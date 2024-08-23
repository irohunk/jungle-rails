# app/controllers/admin/categories_controller.rb
module Admin
  class CategoriesController < ApplicationController
    before_action :authenticate

    def index
      @categories = Category.all
    end

    private

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
      end
    end
  end
end