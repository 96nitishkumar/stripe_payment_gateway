module PostBlock
	class PostsController < ApplicationController

		def create
			post = PostBlock::Post.new(post_params)
			if post.save
				params[:room_ids].each
				Tag.find_or_initialize_by(room_id:id)
			end
		end

		def post_params
			params.required(:post).pemit(:room_id,:title)
		end
	end
end
