class User < ApplicationRecord
  # association
  has_many :messages, dependent: :destroy

  # validation
  validates_presence_of :username
end
