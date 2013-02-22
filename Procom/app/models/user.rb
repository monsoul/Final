class User < ActiveRecord::Base
   attr_accessible :username, :password, :emial,:mobile,:real_name,:pic, :full_pic,:applicant_id,:role,:source,:status,:id

   def self.get_user_by_user_id(user_id)
	   User.find(:first, :conditions => ["id = ?", user_id ])
   end
   
   def self.get_user_by_status(status)
     User.find(:all,:conditions=>["status = ? ",status])
   end
   
   def self.get_user_by_role(role)
     User.find(:all,:conditions=>["role = ? ",role])
   end
   
   def self.get_user_by_role_status(role,status)
     User.find(:all,:conditions=>["role = ? and status = ?",role,status])
   end
end