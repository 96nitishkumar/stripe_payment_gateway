module FaqBlock
	class FaqsController < ApplicationController
		before_action :authentication

		def index
			faqs = FaqBlock::Faq.all
			faqs = faqs.where("category ILIKE ?","%#{params[:category]}%") if params[:category]
			faqs = faqs.where("title ILIKE ?", "%#{params[:title]}%") if params[:title]
			render json:{data:faqs, message:"faqs details"}
		end

		def show
			faq = FaqBlock::Faq.find(params[:id])
			render json:{data: faq, message: "Faq details"}
		end
	end
end