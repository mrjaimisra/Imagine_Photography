class SiteController < ApplicationController
  def index
    @featured_photographer1 = Store.find(1)
    @featured_photographer2 = Store.find(2)
    @featured_photographer3 = Store.find(3)
  end
end
