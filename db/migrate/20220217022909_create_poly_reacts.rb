class CreatePolyReacts < ActiveRecord::Migration[6.1]
  def change
    create_table :poly_reacts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.references :reactable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
