class ChangeNotNulToWorker < ActiveRecord::Migration[6.1]
  def up
    change_column_null :workers, :country, true
    change_column_null :workers, :my_address, true
    change_column_null :workers, :my_phone_number, true
    change_column_null :workers, :family_address, true
    change_column_null :workers, :family_phone_number, true
    change_column_null :workers, :birth_day_on, true
    change_column_null :workers, :abo_blood_type, true
    change_column_null :workers, :rh_blood_type, true
    change_column_null :workers, :hiring_on, true
    change_column_null :workers, :experience_term_before_hiring, true
    change_column_null :workers, :blank_term, true
    change_column_null :workers, :employment_contract, true
    change_column_null :workers, :family_name, true
    change_column_null :workers, :relationship, true
    change_column_null :workers, :sex, true
  end

  def down
    change_column_null :workers, :country, false
    change_column_null :workers, :my_address, false
    change_column_null :workers, :my_phone_number, false
    change_column_null :workers, :family_address, false
    change_column_null :workers, :family_phone_number, false
    change_column_null :workers, :birth_day_on, false
    change_column_null :workers, :abo_blood_type, false
    change_column_null :workers, :rh_blood_type, false
    change_column_null :workers, :hiring_on, false
    change_column_null :workers, :experience_term_before_hiring, false
    change_column_null :workers, :blank_term, false
    change_column_null :workers, :employment_contract, false
    change_column_null :workers, :family_name, false
    change_column_null :workers, :relationship, false
    change_column_null :workers, :sex, false
  end
end
