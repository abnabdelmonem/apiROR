class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true
  validates_uniqueness_of :user_id, scope: [:reactable_id, :reactable_type] #user can't react to the same thing again
  enum reaction_type: %i[like love wow sad angry].freeze
end
