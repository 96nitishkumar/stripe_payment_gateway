module FaqBlock
	class Faq < ApplicationRecord
	def self.ransackable_attributes(auth_object = nil)
    ["category", "created_at", "description", "id", "id_value", "title", "updated_at"]
  end
end
end
