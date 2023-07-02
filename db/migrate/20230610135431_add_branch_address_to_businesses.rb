class AddBranchAddressToBusinesses < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :branch_address, :string
  end
end
