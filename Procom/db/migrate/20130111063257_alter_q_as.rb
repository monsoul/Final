class AlterQAs < ActiveRecord::Migration
  def up
    add_column("qas","ask_user_id",:int,:null=>false)
    add_column("qas","asked_user_id",:int,:null=>false)
    add_column("qas","question_title",:string,:limit=>20,:null=>false)
    add_column("qas","content",:text,:null=>false)
    add_column("qas","origin_question_id",:int)
  end

  def down
    remove_column("qas","origin_question_id")
    remove_column("qas","content")
    remove_column("qas","question_title")
    remove_column("qas","asked_user_id")
    remove_column("qas","ask_user_id")
  end
end
