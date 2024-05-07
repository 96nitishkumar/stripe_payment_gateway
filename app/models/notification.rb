class Notification < ApplicationRecord
  belongs_to :user
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "title", "updated_at", "user_id"]
  end
  require 'fcm'
  before_save :send_push_notification
    def send_push_notification
      # user = User.find_by(id: user_id)
      if user.device_token.present?
        fcm_client = FCM.new(ENV['FCM_SEVER_KEY'])
        options = { priority: 'high',
                    data: {
                      title: title,
                      message: title,
                      user_id: user_id
                    },
                    notification: {
                    title: title,
                    body: title,
                    sound: 'default'
                    }
                  }
        registration_id = user.device_token
        fcm_client.send(registration_id, options)
      end
    rescue Exception => e
      e
    end
end
