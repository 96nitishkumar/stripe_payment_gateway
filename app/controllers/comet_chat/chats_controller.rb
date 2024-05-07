module CometChat
	class ChatsController < ApplicationController
			require 'uri'
require 'net/http'
require 'json'
		def create_user
		  url = URI("https://2570581f6274020a.api-in.cometchat.io/v3/users")
		  
		  http = Net::HTTP.new(url.host, url.port)
		  http.use_ssl = true
		  
		  request = Net::HTTP::Post.new(url)
		  request["accept"] = 'application/json'
		  request["content-type"] = 'application/json'
		  request["apikey"] = '7b68a408c7ccf541a2639db8f0547a3da7e91031'
		  request.body = {
		    uid: "3026",
		    name: "nithin",
		    metadata: {
		      "@private": {
		        email: "nithin@email.com",
		        contactNumber: "9154001144"
		      }
		    }
		  }.to_json
		  
		  response = http.request(request)
		  render json: {data: response.read_body}
		end


		def add_friends

			url = URI("https://2570581f6274020a.api-in.cometchat.io/v3/users/3026/friends")
			
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true
			
			request = Net::HTTP::Post.new(url)
			request["accept"] = 'application/json'
			request["content-type"] = 'application/json'
			request["apikey"] = '7b68a408c7ccf541a2639db8f0547a3da7e91031'
			
			response = http.request(request)
 			render json: {data: response.read_body}
		end

		# def send_message
		#   sender_uid = '1234'
		#   receiver_uid = '3026'
		#   message = 'Hello, this is a test message.'
		  
		#   url = URI("https://2570581f6274020a.api-in.cometchat.io/v3/messages")
		
		#   http = Net::HTTP.new(url.host, url.port)
		#   http.use_ssl = true
		
		#   request = Net::HTTP::Post.new(url)
		#   request["Content-Type"] = 'application/json'
		#   request["apiKey"] = '9ac456dc4e73469b36170a114792bd2560eff1f3' # Replace with your actual API key
		
		#   request.body = JSON.dump({
		#   category:"message",
		#   type:"text",
		#     sender: sender_uid,
		#     receiver: receiver_uid,
		#     receiverType: 'user',
		#     message: "hello"
		#   })
		# debugger
		#   response = http.request(request)
		#   render json: { data: JSON.parse(response.body) }
		# end


		def send_message
			url = URI("https://2570581f6274020a.api-in.cometchat.io/v3/messages")
		
  		http = Net::HTTP.new(url.host, url.port)
  		http.use_ssl = true
		
  		request = Net::HTTP::Post.new(url)
  		request["accept"] = 'application/json'
  		request["onBehalfOf"] = params[:on_behalf_of]
  		request["content-type"] = 'application/json'
  		request["apikey"] = '9ac456dc4e73469b36170a114792bd2560eff1f3'
  		request.body = {
  		  category: "message",
  		  type: "text",
  		  data: {
  		    text: params[:message] 
  		  },
  		  receiver: params[:receiver_id], 
  		  muid: params[:message_id],
  		  receiverType: "user"
  		}.to_json
		
  		response = http.request(request)
  		render json: { data: JSON.parse(response.body) }	
		end

		def create_group
			url = URI("https://2570581f6274020a.api-in.cometchat.io/v3/groups")
			
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true
			
			request = Net::HTTP::Post.new(url)
			request["accept"] = 'application/json'
			request["onBehalfOf"] = '1234'
			request["content-type"] = 'application/json'
			request["apikey"] = '9ac456dc4e73469b36170a114792bd2560eff1f3'
			request.body = JSON.dump(
			{
				type:"public",
				tags:["tag1"],
				guid:"1234",
				name:"Good things",
				password:"1234",
				description:"need to chat",
				owner:"3026"
			})
			response = http.request(request)
			render json: {data: JSON.parse(response.body)}
		end

		def update_group
		  url = URI("https://2570581f6274020a.api-in.cometchat.io/v3/groups/#{params[:group_id]}") # Assuming you pass group_id as a parameter
		
		  http = Net::HTTP.new(url.host, url.port)
		  http.use_ssl = true
		
		  request = Net::HTTP::Put.new(url)
		  request["accept"] = 'application/json'
		  request["content-type"] = 'application/json'
		  request["apikey"] = '9ac456dc4e73469b36170a114792bd2560eff1f3'
		  request.body = {
		    tags: params[:tags], 
		    icon: params[:icon_url] 
		  }.to_json
		
		  response = http.request(request)
		  render json: { data: JSON.parse(response.body) }
		end
		
	end
end
