class Product < ApplicationRecord

	scope :active_items, -> { where(name: "YES") }
	scope :get_item_with_id, -> (user_id) { where(name: user_id, id: 1) }

	def active(name)
		self.update_column(:name, name)
	end

	def destroy
		check_for_events? ? super : self
	end

	private

	def check_for_events?
		errors[:base] << "Cannot delete club while events exist."
    return false
	end
end
