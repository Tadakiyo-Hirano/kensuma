class AddApprovalContentToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :approval_content, :json
  end
end
