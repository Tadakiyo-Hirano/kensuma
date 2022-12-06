# frozen_string_literal: true

module ApplicationHelper
  def page_body_id(params)
    "#{params[:controller].gsub(/\//, '-')}-#{params[:action]}"
  end

  # 下請け階層表示
  def sc_hierarchy(request_order)
    if request_order.instance_of?(RequestOrder)
      case request_order.depth # .depthメソッドで階層の世代を取得できる。
      when 1
        '一次'
      when 2
        '二次'
      when 3
        '三次'
      when 4
        '四次'
      when 5
        '五次'
      end
    else
      '元請'
    end
  end

  # 未入力表示
  def not_input_display(text)
    text.nil? || text.blank? ? '未登録' : text
  end

  # 自身と、自身の階層下の現場情報
  def document_site_info
    request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
    if params[:sub_request_order_uuid]
      RequestOrder.find_by(uuid: params[:sub_request_order_uuid]).order
    else
      request_order.parent_id.nil? ? Order.find(request_order.order_id) : request_order.order
    end
  end

  # 自身と、自身の階層下の書類情報
  def document_info
    request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
    if params[:sub_request_order_uuid]
      RequestOrder.find_by(uuid: params[:sub_request_order_uuid])
    else
      request_order.parent_id.nil? ? Order.find(request_order.order_id) : request_order
    end
  end

  # 和暦表示
  def date_select_ja(src_html)
    dst_html = src_html.gsub(/>\d{4}</) do |m|
      year = m.match(/>(\d{4})</)[1].to_i
      year_ja = case year
                when 2018
                  '平成30/令和元年'
                else
                  "令和#{year - 2018}"
                end
      ">#{year_ja}<"
    end
    dst_html.html_safe
  end

  # 会社名の表示
  def current_business
    current_user.business || current_user.admin_user.business
  end
end
