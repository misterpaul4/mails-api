class User < ApplicationRecord
  # association
  has_many :messages, foreign_key: 'creator_id', dependent: :destroy, class_name: 'Message'
  has_many :receivers, foreign_key: 'receiver_id', class_name: 'Receiver'
  has_many :received_message, through: :receivers

  # validation
  validates_presence_of :username
end
