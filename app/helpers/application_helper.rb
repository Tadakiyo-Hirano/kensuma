# frozen_string_literal: true

module ApplicationHelper
  def page_body_id(params)
    "#{params[:controller].gsub(/\//, '-')}-#{params[:action]}"
  end

  def paying_display
    if current_user.is_prime_contractor == true
      content_tag :span, 'Premium(有料)', class: 'badge badge-warning'
    else
      content_tag :span, 'Free(無料)', class: 'badge badge-primary'
    end
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
      else
        '元請'
      end
    else
      '元請'
    end
  end

  # 未入力表示
  def not_input_display(text)
    text.nil? || text.blank? ? '未登録' : text
  end

  # 自身と、自身の階層下の現場情報（元請情報）
  def document_site_info
    request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
    if params[:sub_request_order_uuid]
      RequestOrder.find_by(uuid: params[:sub_request_order_uuid]).order
    else
      request_order.parent_id.nil? ? Order.find(request_order.order_id) : request_order.order
    end
  end

  # 自身と、自身の階層下の書類情報 →現場情報を含まない情報の取得時
  def document_info
    request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
    if params[:sub_request_order_uuid]
      RequestOrder.find_by(uuid: params[:sub_request_order_uuid])
    else
      request_order.parent_id.nil? ? Order.find(request_order.order_id) : request_order
    end
  end

  # 会社名の表示
  def current_business_name
    current_user.business.name || current_user.admin_user.business.name unless current_user.business.nil?
  end

  # プレースホルダー（氏名）
  def example_name
    return '例 建築　太郎'
  end

  # プレースホルダー（フリガナ）
  def example_name_kana
    return '例 ケンチク　タロウ'
  end

  # プレースホルダー（メールアドレス）
  def example_email
    return '例 example@email.com'
  end

  # プレースホルダー（ハイフン入力の注釈）
  def annotation_hyphen
    return 'ハイフンありでも、なしでも入力出来ます'
  end

  # 任意の複数箇所にハイフン差し込み
  def add_hyphen(array_delimiter, colum_name)
    unless colum_name.include?('-') && colum_name.blank?
      delimiter_sum = 0
      array_delimiter.each_with_index  do |delimiter, number_of_hyphens|
        delimiter_sum += array_delimiter[number_of_hyphens - 1] if number_of_hyphens > 0
        colum_name.insert(delimiter + delimiter_sum + number_of_hyphens, "-")
      end
    end
    return colum_name
  end

  # 電話番号のハイフン差し込み
  def phone_number_add_hyphen(phone_number)
    if phone_number.length == 10
      add_hyphen([4,2], phone_number)
    elsif phone_number.length == 11
      add_hyphen([3,4], phone_number)
    end
  end
end
