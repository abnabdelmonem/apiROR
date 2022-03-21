class AddConstraintOnReactionType < ActiveRecord::Migration[6.1]
  def self.up
    execute "ALTER TABLE reactions ADD CONSTRAINT check_reaction_type CHECK (reaction_type IN (0,1, 2, 3,4) )"
  end

  def self.down
    execute "ALTER TABLE reactions DROP CONSTRAINT check_reaction_type"
  end
end
