class CreateShop < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :page_source_id
      t.string :full_name
      t.string :logo_link
      t.timestamps
    end
  end
end
