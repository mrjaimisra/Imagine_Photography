class Admin::ItemsController < Admin::BaseController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.category_id = params[:item][:category].to_i
    if @item.save
      redirect_to meal_path(@item)
      flash[:notice] = "#{@item.name} created"
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image_url)
  end
end
