class Event < ApplicationRecord
  belongs_to :user

  has_many :participations, dependent: :destroy
  has_many :users, through: :participations


geocoded_by :address
  after_validation :geocode, if: :address_changed?

def self.include_address(location)
  Event.near(location, 15)
end


# scope :include_address, -> (location) { where("address like ?", "%#{@location}%" )}
scope :event_date, -> (formated_date) { where(happen_at: formated_date )}
scope :game_name, -> (game) { where(game: game )}

end
