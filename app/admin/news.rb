ActiveAdmin.register News do
  permit_params :title, :content, :delivered_at, :status

  controller do
    def find_resource
      scoped_collection.where(uuid: params[:id]).first!
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :delivered_at
    column :status do |news|
      news.status_i18n
    end
    actions
  end

  filter :title
  filter :content
  filter :delivered_at
  filter :status, as: :select, collection: News.statuses_i18n.invert.map{ |k, v| [k,  News.statuses[v]]}

  # 下記記述だと、statusカラムは日本語化出来るが、表示カラムが異なる&コメントテーブルとの連携表示ができてない為一旦コメントアウト
  # show do
  #   attributes_table do
  #     row :title
  #     row :content
  #     row :delivered_at
  #     row :status do |news|
  #       news.status_i18n
  #     end
  #   end
  # end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :delivered_at, as: :datetime_picker
      f.input :status, collection: News.statuses_i18n.invert
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :content, :delivered_at, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content, :delivered_at, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
