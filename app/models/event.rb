class Event < ApplicationRecord
  belongs_to :user

  has_many :participations, dependent: :destroy
  has_many :users, through: :participations


geocoded_by :address
  after_validation :geocode, if: :address_changed?


def self.include_address(location)
  Event.near(location, 15)
end

scope :event_date, -> (date) { where(happen_at: date )}
scope :game_name, -> (game) { where(game: game )}

end
