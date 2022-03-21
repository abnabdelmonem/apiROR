class AddPublishedToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :published, :integer, default: 0
  end
end
