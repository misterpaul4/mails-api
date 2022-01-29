class User < ApplicationRecord
  before_save :downcase_fields

  # association
  has_many :messages, foreign_key: 'creator_id', dependent: :destroy, class_name: 'Message'
  has_many :receivers, foreign_key: 'receiver_id', class_name: 'Receiver'
  has_many :received_message, through: :receivers

  def downcase_fields
    self.username.downcase!
  end

  def unread_messages
    received_message.where(read: false)
  end

  # validation
  validates :username, presence: true, uniqueness: true
end
