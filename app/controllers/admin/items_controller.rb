class Admin::ItemsController < Admin::BaseController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_dashboard_path, notice: "#{@item.name} created"
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end