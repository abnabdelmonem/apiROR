class DropTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :posts
    drop_table :users
  end
end
