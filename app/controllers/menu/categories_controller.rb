class Menu::CategoriesController < Menu::BaseController

  def show
    @category = Category.find_by(name: params[:id])
  end
end
