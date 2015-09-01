class Photos::CategoriesController < Photos::BaseController
  def show
    @category = Category.find_by(name: params[:name].capitalize)
    @photos = @category.photos.paginate(page: params[:page]).order('created_at DESC')
  end
end
