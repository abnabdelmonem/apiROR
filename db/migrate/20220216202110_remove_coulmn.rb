class RemoveCoulmn < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :published
  end
end
