class Applicant < ActiveRecord::Base
   attr_accessible :username, :email ,:mobile,:real_name,:school_id,:comments,:acceptance_userid,:committer_status,:status
end
