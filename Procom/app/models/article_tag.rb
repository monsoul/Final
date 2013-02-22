class ArticleTag < ActiveRecord::Base
   attr_accessible :aarticle_id, :tag_id
   def self.get_article_count_by_tag_id(tag_id)
     ArticleTag.find(:all,:conditions=>["tag_id = ?", tag_id]).count
   end
end
