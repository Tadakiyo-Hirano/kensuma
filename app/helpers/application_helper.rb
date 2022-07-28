# frozen_string_literal: true

module ApplicationHelper
  def page_body_id(params)
    "#{params[:controller].gsub(/\//, '-')}-#{params[:action]}"
  end

  # 下請け階層表示
  def sc_hierarchy(request_order)
    case request_order.depth # .depthメソッドで階層の世代を取得できる。
    when 0
      '元請け'
    when 1
      '一次下請け'
    when 2
      '二次下請け'
    when 3
      '三次下請け'
    when 4
      '四次下請け'
    when 5
      '五次下請け'
    end
  end

  # 未入力表示
  def not_input_display(text)
    text.nil? ? '未登録' : text
  end

  # 自身と、自身の階層下の書類用情報取得
  def document_info
    unless params[:sub_request_order_uuid]
      RequestOrder.find_by(uuid: params[:request_order_uuid])
    else
      RequestOrder.find_by(uuid: params[:sub_request_order_uuid])
    end
  end
end
