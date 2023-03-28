module FieldWorkersHelper
  
  def selected_value(id, column, action, controller)
    if action == "update_workers" && controller == "users/orders/field_workers"
      params[:order]&.dig(:field_workers, id.to_s, column.to_sym)
    elsif action == "update_workers" && controller == "users/request_orders/field_workers"
      params[:request_order]&.dig(:field_workers, id.to_s, column.to_sym)
    else
      worker = FieldWorker.find_by(id: id)
      worker.send(column)
    end
  end
end