class AddUuidNews < ActiveRecord::Migration[6.1]
  def up
    add_column :news, :uuid, :string, null:false
  end
end
