class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.all
  end

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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    @item.update(item_params)

    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image_url)
  end
end