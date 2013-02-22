class Qa < ActiveRecord::Base

  attr_accessible :ask_user_id, :asked_user_id,:content,:origin_question_id,:question_title,:id,:updated_at

  #获取user提交的所有问题
  def self.get_all_question_by_user_id(user_id)
	  Qa.find(:all, :conditions => ["ask_user_id = ? and (origin_question_id is null or origin_question_id = 0)", user_id])
  end

  #获取user被提问的问题
  def self.get_all_asked_question_by_user_id(userid)
    Qa.find(:all,:conditions=>["asked_user_id = ? and origin_question_id is null", userid])
  end
  
  def self.get_answer_by_question_id(question_id)
  	Qa.find(:first, :conditions => ["origin_question_id = ?", question_id ])
  end
  
  def self.get_question_by_question_id(question_id)
  	Qa.find(:first, :conditions => ["id = ?", question_id])
  end
  
end
