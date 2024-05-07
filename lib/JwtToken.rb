module JwtToken
	SECRET = "JWTTOKEN"

	def self.encode_data(payload)
			data = {
				id: payload.id,
				exp: 500.minutes.from_now.to_i
			}
			token = JWT.encode data, SECRET, 'HS256'
	end

	def self.decode_data(token)
		begin 
			data = JWT.decode token,SECRET,true, {algorith: "HS256"}
			return data
		rescue StandardError => e
		   return e.message
		end
	end
end