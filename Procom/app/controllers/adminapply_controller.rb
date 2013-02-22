#encoding: utf-8
require 'digest/md5'

class AdminapplyController < AdminController

  def index
   
    @users = Applicant.find :all, conditions: ["status = 0"]


    #respond_to do |format|
     #   format.html # index.html.erb
      #  format.json { render json: @users }
      #end
  end


  def mail
    #HcdMailer.confirm("chenge3k@qq.com").deliver
    #@users=[]
    #return

  end

  #method
  def approve
  	id = params[:id]

    if not_approved? id
      do_approve id
      flash[:notice] = 'OK'
    else
      flash[:notice] = '已经审批过了'
    end
    redirect_to '/adminapply'
  end
  
  ##private
  private

  def not_approved?(id)
    user = User.find :first, conditions: ["applicant_id = ?", id]
    user.blank? 
  end

  def do_approve(id)
    applicant = Applicant.find id
    applicant.status = 1
    applicant.save

    user = User.new
    user.username = applicant.username
    user.password = Digest::MD5.hexdigest '123456'
    user.email = applicant.email
    user.mobile = applicant.mobile
    user.real_name = applicant.real_name
    user.applicant_id = id
    user.status = 1
    user.save
  end


end
