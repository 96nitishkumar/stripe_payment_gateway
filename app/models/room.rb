class Room < ApplicationRecord
  belongs_to :user, class_name: "User"
  has_many :bookings,  dependent: :destroy
  validates :price, presence: true
  geocoded_by :location
  enum status:["Pending", "Accept", "Reject"]
  before_create :room_status
  def self.ransackable_associations(auth_object = nil)
    ["user","bookings"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "location", "max_days", "name", "price", "updated_at", "user_id" ,"status",'latitude','longitude']
  end

  def room_status
    self.status = "Pending" if status.nil?
  end
end
