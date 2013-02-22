class Article < ActiveRecord::Base
   attr_accessible :title, :brief,:content,:article_type,:qa_id,:pic,:user_id,:id,:updated_at
   
   def self.get_all_article(page)
     Article.paginate :page =>page,:per_page=>1,:conditions => [""]
   end
   
   def self.get_article_by_article_id(article_id)
     Article.find(article_id)
   end
   
   def self.get_all_article_count()
     Artilce.all.count
   end
      
   def self.get_article_by_article_type(article_type,page)
     Article.paginate :page =>page,:per_page=>1,:conditions => ["article_type=?",article_type]
   end

   def self.get_article_count_by_article_type(article_type)
     Article.find(:all,:conditions=>["article_type = ?", article_type]).count
   end
   
   def self.get_article_by_tag_id(tag_id,page)
     Article.paginate_by_sql(["select articles.* from articles,article_tags
            where article_tags.tag_id = ? and articles.id=article_tags.article_id",tag_id],:page=>page,:per_page=>1)
   end
   
end
