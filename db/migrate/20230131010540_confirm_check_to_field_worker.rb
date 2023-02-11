class ConfirmCheckToFieldWorker < ActiveRecord::Migration[6.1]
  def change
    add_column :field_workers, :prime_contractor_confirmation, :string # 元請け確認（現場作業員に関連付け用）
  end
end
