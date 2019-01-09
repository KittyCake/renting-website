class AddLastsigninipToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_sign_in_ip, :inet
  end
end
