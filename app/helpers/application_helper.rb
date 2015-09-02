module ApplicationHelper
  def photo_categories
    Category.all
  end

  def photographer
    Store.find_by(id: current_user.store_id)
  end
end
