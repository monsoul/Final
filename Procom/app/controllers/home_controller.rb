class HomeController < ApplicationController
  require 'digest/md5'  
    
  def index
    @student=User.find(:first, :conditions => ["role='student' and status='USER_HPD'"])
    @student_app=Applicant.find(@student.applicant_id)
    @student1s=User.find_by_sql("select id,pic from Users where role='student' and status='USER_HPD' limit 0,5")
    @student2s=User.find_by_sql("select id,pic from Users where role='student' and status='USER_HPD' limit 0,5")
    @teacher1s=User.find_by_sql("select id,pic from Users where role='teacher' and status='USER_HPD' limit 0,5")
    @teacher2s=User.find_by_sql("select id,pic from Users where role='teacher' and status='USER_HPD' limit 0,5")
  end
  
  def showuser
    
  end
  
  def userinfo
    user_id = params[:user_id]
    @user=User.find(user_id)
    @user_app=Applicant.find(@user.applicant_id)
  end
  
def editinfo
  if check_login
    user_id=session[:userid]
    @user=User.find(user_id)
    unless request.get?
      user_id=session[:userid]
      old_password=Digest::MD5.hexdigest(params[:eidt_old_password])
      new_password=Digest::MD5.hexdigest(params[:eidt_new_password])
      repeat_password=Digest::MD5.hexdigest(params[:eidt_repeat_password])
      @user=User.find(user_id)
      if(!@user)
        render_json("fail","fail")
      elsif @user.password == old_password && new_password == repeat_password
        @user.password=new_password
        if @user.save
          render_json("success","success")
        else
          render_json("fail","fail")
        end
      else
        render_json("fail","old password error or two password is different")
      end        
    end
  else
    render_json("need_login","need_login")
  end
end
  
  def userinfodialog
    user_id = params[:user_id]
    @user=User.find(user_id)
  end
  
  def login
    unless request.get?
      username = params[:login_username]
      password = Digest::MD5.hexdigest(params[:login_password])
      @user = User.find_by_username(username)
      if(!@user)
        render_json("fail","fail")
      elsif @user.password == password && @user.status!='USER_LOCK'
        cookies[:userid]={ :value => @user.id, :expires => 2.weeks.from_now.utc}
        cookies[:username]={ :value => @user.username, :expires => 2.weeks.from_now.utc}
        cookies[:role]={ :value => @user.role, :expires => 2.weeks.from_now.utc}
        session[:userid]= @user.id
        render_json("success","success")
      else
        render_json("fail","fail")
      end        
    end
  end

  def dictionary
    unless request.get?
      @dictionary=Dictionary.new
      @dictionary.value_id=params[:value_id]
      @dictionary.value_content=params[:value_content]
      @dictionary.value_content_cn=params[:value_content_cn]
      @dictionary.value_type=params[:value_type]
      @dictionary.save
    end
  end
  
  def dictionaries
    @dictionaries=Dictionary.all
  end
  
  def register
    unless request.get?
      username = params[:username]
      password = params[:password]
      rpassword =params[:rpassword]
      real_name = params[:real_name]
      email=params[:email]
      mobile=params[:mobile]
      pic="1.jpg"
      role="student"
=begin
数据验证
=end
      @user = User.new
      @user.username=username
      @user.password=Digest::MD5.hexdigest(password)
      @user.email=email
      @user.real_name=real_name
      @user.pic=pic
      @user.mobile=mobile
      @user.role=role
      @user.status=0
#保存用户成功 
      if @user.save
        render_json("success","success")
      else
        render_json("fail","fail")
      end
    end
  end
  
  def check_login
    if session[:userid]==nil&&cookies[:userid]==nil
      return false
    else
      session[:userid]=cookies[:userid]
      return true
    end
  end
  
  def check
    unless request.get?
      username=params[:username]
      @user = User.find(:all, :conditions => ["username = ?", username]) 
      if(@user.empty? )
        render_json("success","success")
      else
        render_json("fail","fail")
      end
    end
  end

  def schools
    city=params[:city]
    @schools=School.find(:all, :conditions => ["city = ?", city])
  end
  
  def teachers
    @teachers=User.find(:all,:conditions=>['role=?','teacher'])
  end
  
  def all_questions
    @qas=Qa.get_all_question_by_user_id(session[:userid])
  end
  
  def answer
    @qa=Qa.get_answer_by_question_id(params[:my_question_id])
  end
  
  def applicant
    unless request.get?
      username=params[:applicant_username]
      real_name=params[:applicant_name]
      mobile=params[:applicant_phone]
      email=params[:applicant_email]
      school_id=params[:applicant_schoolid]
      keywords=params[:applicant_keywords]
      comments=params[:applicant_comment]
      
      @applicant=Applicant.new
      @applicant.username=username
      @applicant.real_name=real_name
      @applicant.mobile=mobile
      @applicant.email=email
      @applicant.school_id=school_id
      @applicant.keywords=keywords
      @applicant.comments=comments
      @applicant.committer_status=0
      @applicant.status=0
      
      if @applicant.save
        render_json("success","success")
      else
        render_json("fail","fail")
      end
    end
  end

def ask_question
  if check_login
    unless request.get?
      ask_user_id=session[:userid]
      asked_user_id=params[:teacher_id]
      content=params[:ask_content]
      title=params[:ask_title]
      @qa=Qa.new
      @qa.ask_user_id=ask_user_id
      @qa.asked_user_id=asked_user_id
      @qa.content=content
      @qa.question_title=title
      
      if @qa.save
        render_json("success","success")
      else
        render_json("fail","fail")
      end
    end
  else
    render_json("need_login","need_login")
  end
end
  
  #获取所有学生的提问
  def ask_questions
    @qas=Qa.get_all_asked_question_by_user_id(session[:userid])
  end

  def answer_question
    unless request.get?
      asked_user_id=session[:userid]
      ask_user_id=params[:ask_user_id]
      question_id=params[:answer_id]
      content=params[:content]
      title=params[:answer_title]
      @qa=Qa.new
      @qa.ask_user_id=ask_user_id
      @qa.asked_user_id=asked_user_id
      @qa.content=content
      @qa.origin_question_id=question_id
      @qa.question_title=title
      
      @newqa=Qa.get_question_by_question_id(question_id)
      @newqa.origin_question_id=0
      @newqa.save
      
      if @qa.save
        render_json("success","success")
      else
        render_json("fail","fail")
      end
    end
  end
  
  def answerquestions
  end

 def loginview
 end

  def log_off
    cookies.delete :userid
    cookies.delete :username
    cookies.delete :role
    session[:userid]=nil           
    redirect_to :controller => 'index', :action => 'index'
  end
  
  def render_json(result,message)
    render :json => {:result=>result,:message=>message}
  end
  
end
