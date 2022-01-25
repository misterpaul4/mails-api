class Message < ApplicationRecord
  # association
  belongs_to :creator, class_name: 'User'
  has_many :recipients, foreign_key: 'received_message_id', class_name: 'Receiver'

  has_many :receivers, through: :recipients, dependent: :destroy


  # validation
  validates_presence_of :subject
end
