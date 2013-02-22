module ReadHelper
  def is_common(article)
  	article and article.article_type =='ATC_QA'
  end
  
  def is_el(article)
    article and article.article_type=='ATC_EL'
  end
end
