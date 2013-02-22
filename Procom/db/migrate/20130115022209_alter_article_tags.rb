class AlterArticleTags < ActiveRecord::Migration
  def up
    add_column("article_tags","article_id",:int,:null=>false)
    add_column("article_tags","tag_id",:int,:null=>false)
  end

  def down
    remove_column("article_tags","tag_id")
    remove_column("article_tags","article_id")
  end
end
