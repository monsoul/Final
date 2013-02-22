class AlterUsers < ActiveRecord::Migration
  def up
      add_column("users","username",:string,:limit=>20,:null=>false)
      add_column("users","password",:string,:limit=>32,:null=>false)
      add_column("users","email",:string,:linit=>32,:null=>false)
      add_column("users","mobile",:string,:limit=>15)
      add_column("users","real_name",:string,:limit=>20,:null=>false)
      add_column("users","pic",:string)
      add_column("users","full_pic",:string)
      add_column("users","applicant_id",:int)
      add_column("users","role",:string,:limit=>20)
      add_column("users","status",:string,:limit=>10,:null=>false)
    end

    def down
      remove_column("users","status")
      remove_column("users","role")
      remove_column("users","applicant_id")
      remove_column("users","full_pic")
      remove_column("users","pic")
      remove_column("users","real_name")
      remove_column("users","mobile")
      remove_column("users","email")
      remove_column("users","password")
      remove_column("users","username")
    end
end
