class AddUserIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference(:products, :seller, foreign_key: { to_table: :users })
  end
end
