class User < ActiveRecord::Base
	has_one :profile, dependent: :destroy
	has_many :todo_lists, dependent: :destroy
	has_many :todo_items, through: :todo_lists, source: :todo_items, dependent: :destroy
	validates :username, presence: true
	has_secure_password

	def get_completed_count
		todo_items.to_a.count { |item| item.completed }
		# count = 0
		# todo_items.each { |item|
		# 	if item.completed
		# 		count+=1
		# 	end
		# }
		# count
	end
end
