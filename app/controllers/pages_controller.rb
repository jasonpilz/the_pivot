class PagesController < ApplicationController
  def home
    @items = Item.all.select { |item| item.store.status == "accepted"}.take(6)
    #@items = Item.joins(:store
    @categories = Category.all
    @stores = Store.where(status: "accepted").take(6)
  end

  def about
  end
end
