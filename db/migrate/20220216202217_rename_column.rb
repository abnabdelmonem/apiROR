class RenameColumn < ActiveRecord::Migration[6.1]
  def up
    rename_column :posts, :published_temp, :published
  end

  def down
    rename_column :posts, :published, :published_temp
  end
end
