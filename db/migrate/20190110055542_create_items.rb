class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_name
      t.string :item_photo
      t.text :description
      t.integer :price_worth
      t.integer :pricee_daily
      t.integer :price_weekly
      t.integer :price_monthly
      t.string :post_code
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
