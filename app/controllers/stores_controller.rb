class StoresController < ApplicationController
  def index
    @photographers = Store.all
  end

  def show

  end
end
