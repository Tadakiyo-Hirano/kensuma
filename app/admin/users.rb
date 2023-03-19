ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  permit_params :email, :password, :password_confirmation, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at, :name, :role, :is_prime_contractor

  # controller do
  #   def scoped_collection
  #     end_of_association_chain.where(role: 'admin')
  #   end
  # end

  index do
    column :name
    column :email
    bool_column :is_prime_contractor
    column :role, &:role_i18n

    # 閲覧編集削除などのリンク表示
    actions
  end

  filter :email

  show do
    attributes_table do
      row :name
      row :email
      bool_row :is_prime_contractor
      row :role, &:role_i18n
    end
  end

  form do |f|
    @form = f.object
    if @form.new_record?
      @form[:is_prime_contractor] = true
    end

    f.inputs do
      f.input :name
      f.input :email
      f.input :is_prime_contractor, hint: '下請けに変更する場合はチェックを外してください'
      f.input :password
      f.input :password_confirmation
      # パスワードの一時表示一旦コメントアウト
      # f.button "表示", type: :button, id: "btn_passview"
      # f.input :password_confirmation, type: "password", id: "input_pass", name: "input_pass", value: ""
      f.hidden_field :role, value: 'admin'
    end
    f.actions
  end
end
