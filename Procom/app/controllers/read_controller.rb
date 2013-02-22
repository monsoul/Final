class ReadController < ApplicationController
  def index
    @tags=Tag.all
  end
  
  def article
    article_type=params[:article_type]
    tag_id=params[:tag_id]
    page=params[:page]
    if(article_type=="all" and tag_id=="all")
      @articles=Article.get_all_article(page)
    elsif article_type!="all"
      @articles=Article.get_article_by_article_type(article_type,page)
    else
      @articles=Article.get_article_by_tag_id(tag_id,page)
    end
    @article=@articles[0]
    @tags=Tag.find_by_sql(["select tags.id,tags.name from tags,article_tags where article_tags.article_id = ? and article_tags.tag_id=tags.id",@article.id])
    if @article.article_type=='ATC_QA'
      @answer=Qa.get_question_by_question_id(@article.qa_id)
      @ask=Qa.get_question_by_question_id(@answer.origin_question_id)
      @ask_user=User.get_user_by_user_id(@answer.ask_user_id)
      @asked_user=User.get_user_by_user_id(@answer.asked_user_id)
    else
      @user=User.get_user_by_user_id(@article.user_id)
    end
  end
  
  def showarticle
    @alltags=Tag.all
    article_id=params[:article_id]
    @article=Article.find(article_id)
    @tags=Tag.find_by_sql(["select tags.id,tags.name from tags,article_tags where article_tags.article_id = ? and article_tags.tag_id=tags.id",@article.id])
    if @article.article_type=='ATC_QA'
      @answer=Qa.get_question_by_question_id(@article.qa_id)
      @ask=Qa.get_question_by_question_id(@answer.origin_question_id)
      @ask_user=User.get_user_by_user_id(@answer.ask_user_id)
      @asked_user=User.get_user_by_user_id(@answer.asked_user_id)
    else
      @user=User.get_user_by_user_id(@article.user_id)
    end
  end
  
  def articles
    article_type=params[:article_type]
    tag_id=params[:tag_id]
    if(article_type=="all" and tag_id=="all")
      @count=Article.all.count
    elsif (article_type!="all")
      @count=Article.get_article_count_by_article_type(article_type)
    else
      @count=ArticleTag.get_article_count_by_tag_id(tag_id)
    end
    @ajaxurl="?article_type="+article_type+"&tag_id="+tag_id
  end
    
end
