class IndexController < ApplicationController
  def index
    @student=User.find(:first, :conditions => ["role='student' and status='USER_HPD'"])
    @student_app=Applicant.find(@student.applicant_id)
    @student1s=User.find_by_sql("select id,pic from Users where role='student' and status='USER_HPD' limit 0,5")
    @student2s=User.find_by_sql("select id,pic from Users where role='student' and status='USER_HPD' limit 0,5")
    @teacher1s=User.find_by_sql("select id,pic from Users where role='teacher' and status='USER_HPD' limit 0,5")
    @teacher2s=User.find_by_sql("select id,pic from Users where role='teacher' and status='USER_HPD' limit 0,5")
  end
end
