module IndexHelper
  def is_teacher(user)
  	user and user.role =='teacher'
  end
  
  def is_student(user)
    user and user.role=='student'
  end
end
