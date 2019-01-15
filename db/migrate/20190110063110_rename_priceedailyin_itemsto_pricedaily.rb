class RenamePriceedailyinItemstoPricedaily < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :pricee_daily, :price_daily
  end
end
