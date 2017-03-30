class RenameBodyToDescriptionOnProducts < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :body, :description
  end
end
