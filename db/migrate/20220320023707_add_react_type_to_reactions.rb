class AddReactTypeToReactions < ActiveRecord::Migration[6.1]
  def change
    add_column :reactions, :reaction_type, :integer, default: 0
  end
end
