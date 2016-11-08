class Profile < ActiveRecord::Base
  belongs_to :user

  validate :both_names_not_null, :gender_bias
  validates :gender, inclusion: { in: ["male", "female"] }

  def both_names_not_null
  	if first_name.nil? && last_name.nil?
  		errors.add(:first_name, "both first name and last name cannot be null")
  	end
  end

  def gender_bias
  	if gender == "male" && first_name == "Sue"
  		errors.add(:gender, "this course is full of gender bias")
  	end
  end

  def self.get_all_profiles(min, max)
  	Profile.where("birth_year BETWEEN :min_year AND :max_year", min_year: min, max_year: max).order(birth_year: :asc).to_a
  end
end
