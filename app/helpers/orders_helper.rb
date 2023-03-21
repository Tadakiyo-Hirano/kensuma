module OrdersHelper
  def request_order_uuid(order)
    @request_order = order.request_orders.map { |request_order| request_order.uuid if request_order.parent_id == nil }.compact.join(" ")
  end
end
