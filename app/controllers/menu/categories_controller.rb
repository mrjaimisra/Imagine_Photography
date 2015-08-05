class Menu::CategoriesController < Menu::BaseController
  def show
    @category = Category.find_by(id: params[:id])
  end
end
