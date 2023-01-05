class AddCulumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_prime_contractor, :boolean, default: false, null: false
  end
end
