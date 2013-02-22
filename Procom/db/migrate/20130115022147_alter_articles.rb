
class AlterArticles < ActiveRecord::Migration
  def up
    add_column("articles","title",:string,:limit=>30,:null=>false)
    add_column("articles","brief",:text)
    add_column("articles","content",:text)
    add_column("articles","article_type",:string,:limit=>10,:null=>false)
    add_column("articles","qa_id",:int)
    add_column("articles","pic",:string,:limit=>255)
    add_column("articles","user_id",:int,:null=>false)
  end

  def down
    remove_column("articles","user_id")
    remove_column("articles","pic")
    remove_column("articles","qa_id")
    remove_column("articles","article_type")
    remove_column("articles","content")
    remove_column("articles","brief")
    remove_column("articles","title")
  end
end
