class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: { pending: 0, interested: 1, confirmed: 2, declined: 3 }
end
