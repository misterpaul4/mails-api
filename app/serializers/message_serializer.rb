class MessageSerializer < ActiveModel::Serializer
  attributes :id, :subject, :content, :read, :creator

  belongs_to :creator, class_name: 'User'
  has_many :recipients, foreign_key: 'received_message_id', class_name: 'Receiver'
  has_many :receivers, through: :recipients, dependent: :destroy
end
