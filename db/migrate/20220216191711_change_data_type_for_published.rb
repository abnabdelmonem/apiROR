class ChangeDataTypeForPublished < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :published, :string
  end
end
