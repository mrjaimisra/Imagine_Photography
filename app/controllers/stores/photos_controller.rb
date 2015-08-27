class Stores::PhotosController < ApplicationController
  def index
    @store = Store.find_by(url: params[:photographer])
    @photos = @store.photos
  end
end
