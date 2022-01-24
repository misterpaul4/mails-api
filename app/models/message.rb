class Message < ApplicationRecord
  # association
  belongs_to :user

  # validation
  validates_presence_of :subject
end
