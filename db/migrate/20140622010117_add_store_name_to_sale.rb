class AddStoreNameToSale < ActiveRecord::Migration
  def change
    add_column :sales, :store_name, :string
  end
end
