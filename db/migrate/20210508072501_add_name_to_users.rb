# frozen_string_literal: true

class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name,                     :string
    add_column :users, :age,                      :integer
    add_column :users, :gender,                   :integer
    add_column :users, :invited_user_ids,         :json # 自身が招待したユーザー(自身の傘下のユーザー)
    add_column :users, :invitation_sent_user_ids, :json # 自身が招待リクエストした招待承認前のユーザー(自身の傘下のユーザー)
  end
end
