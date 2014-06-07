class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :url
      t.string :picture

      t.timestamps
    end
  end
end
