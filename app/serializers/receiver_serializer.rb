class ReceiverSerializer < ActiveModel::Serializer
  attributes :id, :receiver, :received_message

  belongs_to :receiver, class_name: 'User'
  belongs_to :received_message, class_name: 'Message'
end
