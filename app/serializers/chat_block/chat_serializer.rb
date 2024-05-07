module ChatBlock
  class ChatSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :name

    has_many :accounts, serializer: ::UserSerializer
    attribute :accounts_chats do |object, params|
      serializer = ChatBlock::AccountsChatsSerializer.new(
        object.accounts_chats, {params: params}
      )
      serializer.serializable_hash[:data]
    end

    attribute :messages do |object, params|
      serializer = ChatBlock::ChatMessageSerializer.new(
        object.messages, {params: params}
      )
      serializer.serializable_hash[:data]
    end
  end
end
