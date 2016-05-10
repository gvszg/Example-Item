class CategoriesController < ApplicationController
  def show
    @category = Category.find(params['id'])
    @items = @category.items.priority.paginate(page: params['page'], per_page: 18)
  end
end
