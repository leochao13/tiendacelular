class ProductChannel < ApplicationCable::Channel
  ApplicationCable::Channel
  def subscribed
    stream_from "product_#{params[:room]}"
  end

end
