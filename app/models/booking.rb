class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :one_transaction, class_name: "TransactionBlock::Transaction", dependent: :destroy
  # validates :user_id, uniqueness: { scope: :room_id , message: "this property is in your booking list"}
  before_create :check_dates
  before_create :check_room_status
  after_create :create_transaction
  after_update :refund_transaction
  after_update :cancel_booking

  def self.ransackable_associations(auth_object = nil)
    ["room", "user",'one_transaction']
  end
  def self.ransackable_attributes(auth_object = nil)
    ["booking_days", "created_at", "from_date", "id", "id_value", "room_id", "status", "to_date", "total_price", "updated_at", "user_id"]
  end
  enum status:["Pending", "Accept", "Reject","Cancel"]


  def check_room_status
    a = Room.find_by(id: room_id)
    if a.status == "Pending"
      errors.add(:base, "this room is in contraction mode")
      throw(:abort)
    end
  end

  def create_transaction
    transaction = TransactionBlock::Transaction.create(total_amount:self.total_price,transaction_status:"Pending",user_id:self.user_id,booking:self)
    unless transaction.valid?
      errors.add(:base, "transaction faild")
      throw(:abort)
    end
  end
  
  def check_dates
    room = Room.find_by(id: room_id)
    bookings = Booking.where(room_id: room_id)
    user_booking = Booking.where(room_id: room_id, user_id: user.id)
    self.booking_days = (to_date-from_date).to_i
    self.total_price = room&.price * booking_days
    self.status = 'Pending'
    if to_date < from_date
      errors.add(:base, "you need to give proper dates")
      throw(:abort)
    elsif room.max_days < booking_days
      errors.add(:base, "you need to book max #{room.max_days} days")
      throw(:abort)
    elsif bookings.present? && bookings.where('from_date < ? AND to_date > ?', to_date, from_date).present?
      errors.add(:base, "In #{from_date} these dates rooms are not available")
      throw(:abort)
    elsif user.rooms.ids.include?(room_id)
      errors.add(:base, "You no need to book this room this is your room")
      throw(:abort)
    elsif user_booking.present? && from_date < user_booking.pluck("to_date").max
      errors.add(:base, "This room you alread booked in these dates")
      throw(:abort)
    end
  end

  def refund_transaction
    if self.status == "Reject"
      # transaction = TransactionBlock::Transaction.find_by(user_id:self.user_id,booking:self)
      refund = self.one_transaction.total_amount-(self.one_transaction.total_amount*0.2)
      self.one_transaction.update(transaction_status:"Refund", refund: refund)
    end
  end

  def cancel_booking
    if self.status == "Cancel" && self.one_transaction.transaction_status == "Success"
      # transaction = TransactionBlock::Transaction.find_by(user_id:self.user_id,booking:self)
      refund = self.one_transaction.total_amount-(self.one_transaction.total_amount*0.4) 
      refund = self.total_price if (self.from_date-Date.today) > 1
      self.one_transaction.update(transaction_status:"Cancel", refund: refund)
    elsif self.status == "Cancel"
      self.one_transaction.update(transaction_status:"Cancel", refund: 0)
    end
  end

end
