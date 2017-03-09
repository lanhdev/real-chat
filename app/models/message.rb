class Message < ApplicationRecord
  belongs_to :room, inverse_of: :messages
  validates_presence_of :username, :body
end
