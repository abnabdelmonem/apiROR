class RenamePolyReacts < ActiveRecord::Migration[6.1]
  def self.up
    rename_table :poly_reacts, :reactions
  end

  def self.down
    rename_table :reactions, :poly_reacts
  end
end
