module ChatBlock
	class MessagesController < ApplicationController
		before_action :authentication

		def create
    	@chat = Chat.find(message_params[:chat_id])
    	if @chat.users.include?(current_user)
    	  @message = @current_user.sent_messages.build(message_params)
    	  if @message.save
    	    render json: @message
    	  else
    	    render json: { error: "Failed to send message" }, status: :unprocessable_entity
    	  end
    	else
    	  render json: { error: "Unauthorized" }, status: :unauthorized
    	end
  	end

  	private
	
  	def message_params
  	  params.require(:message).permit(:message, :receiver_id, :chat_id, attachments: [])
  	end
	end
end

  	  







# def accept
#     invitation = Invitation.find(params[:invitation_id])
#     chat = invitation.chat
#     UserChat.create(user: current_user, chat: chat)
#     invitation.destroy
#     render json: { message: "Accepted invitation and joined chat" }
#   end