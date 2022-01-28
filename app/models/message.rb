class Message < ApplicationRecord
  # association
  belongs_to :creator, class_name: 'User'
  has_many :recipients, foreign_key: 'received_message_id', dependent: :destroy, class_name: 'Receiver'
  has_many :receivers, through: :recipients


  # validation
  validates_presence_of :subject
end
