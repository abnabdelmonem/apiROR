class ChangeDataType < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :published_temp, :boolean
  end
end
