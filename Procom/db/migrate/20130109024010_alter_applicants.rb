
class AlterApplicants < ActiveRecord::Migration
  def up
    add_column("applicants","username",:string,:limit=>20,:null=>false)
    add_column("applicants","email",:string,:limit=>20,:null=>false)
    add_column("applicants","mobile",:string,:limit=>20,:null=>false)
    add_column("applicants","real_name",:string,:limit=>20,:null=>false)
    add_column("applicants","school_id",:int,:null=>false)
    add_column("applicants","keywords",:string,:limit=>20)
    add_column("applicants","comments",:text)
    add_column("applicants","acceptance_userid",:int)
    add_column("applicants","committer_status",:string,:limit=>10,:null=>false)
    add_column("applicants","status",:string,:limit=>10)
  end

  def down
    remove_column("applicants","status")
    remove_column("applicants","committer_status")  
    remove_column("applicants","acceptance_userid")
    remove_column("applicants","comments")
    remove_column("applicants","keywords")
    remove_column("applicants","school_id")
    remove_column("applicants","real_name")
    remove_column("applicants","mobile")
    remove_column("applicants","email")  
    remove_column("applicants","username")
  end
end
