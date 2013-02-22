class School < ActiveRecord::Base
	attr_accessible :id,:school_name, :province, :city, :pic,:status

	def self.get_schools_by_ciy(city)
		@schools = School.find(:all, :conditions => ["city = '?'", city])
	end

	def self.get_all_teachers
		School.find(:all, :conditions => ["role = 'teacher'"])
	end
end
