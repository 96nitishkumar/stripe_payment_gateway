module ChatBlock
  class ChatsController < ApplicationController
    # before_action :find_chat, only: [:read_messages]

    def create
    	chat = ChatBlock::Chat.new(chat_params)
    	chat.chat_type = 0
    	chat.save
    	[@current_user.id,params[:receive_id_]].each do |user|
    		UserChat.create(user_id: @current_user, chat: chat)
    	end
    	render json: chat
    end

    def index
    	@chats = current_user.chats
    	render json: @chats
  	end

  	def show
    	if @chat.users.include?(@current_user)
    	  render json: @chat
    	else
    	  render json: { error: "Unauthorized" }, status: :unauthorized
    	end
  	end

  	def chat_params
      params.require(:chat).permit(:name)
    end

    def find_chat
      @chat = Chat.find_by_id(params[:chat_id])
      render json: {message: "Chat room is not valid or no longer exists"} unless @chat
    end
  end
end
