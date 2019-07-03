class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:notice] = "You now have #{pluralize(cart.item_count(item.id), item.name)} in your cart."
    redirect_to items_path
  end

  def show
    #cart = Cart.new(session[:cart])
    @items = cart.contents.map do |item_id, quanitity|
      Item.find(item_id)
    end
  end

  def destroy
    session[:cart] = {}
    redirect_to cart_path
  end

  def remove_item
    cart.remove_item(params[:item_id])
    session[:cart] = cart.contents

    redirect_to cart_path
  end
end
