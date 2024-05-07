class User < ApplicationRecord
	has_secure_password
	has_many :rooms, dependent: :destroy, class_name: "Room"
	has_many :bookings,  dependent: :destroy
	has_many :notifications, dependent: :destroy
	# has_one_attached :image
	has_many :transactions, class_name: 'TransactionBlock::Transaction'

	# has_many :sent_messages ,class_name: "ChatBlock::Message", foreign_key: "sender_id"
	#  has_many :received_messages, class_name: "ChatBlock::Message", foreign_key: "receiver_id"

	# has_many :user_chats
  # has_many :chats, through: :user_chats
	validates :email, presence: { message: 'email ivvara sale' }
	# has_many :bus_bookings,class_name: "BookingBlock::BusBooking"

	def self.ransackable_associations(auth_object = nil)
    ["bookings", "rooms", "notifications","transactions","bus_bookings"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "password_digest", "phone_number", "updated_at", "device_token","stripe_id","stripe_connect_id"]#,"image_attachment_id","image_blob_id"]
  end


  def self.gen_pdf
  	pdf = WickedPdf.new.pdf_from_string(render_to_string('views/users/stripe.html.erb'))
  	save_path = Rails.root.join('simple.pdf')
  	File.open(save_path,'wb') do |file|
  		file<<pdf
  	end
  	# save_data(pdf,:filename => "test.pdf", type: 'application/pdf')
  end
end
