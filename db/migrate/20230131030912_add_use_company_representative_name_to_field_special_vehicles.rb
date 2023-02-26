class AddUseCompanyRepresentativeNameToFieldSpecialVehicles < ActiveRecord::Migration[6.1]
  def change
    add_column :field_special_vehicles, :use_company_representative_name, :string
    add_column :field_special_vehicles, :owning_company_representative_name, :string
  end
end
