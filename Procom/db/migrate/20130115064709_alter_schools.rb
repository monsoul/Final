class AlterSchools < ActiveRecord::Migration
  def up
    add_column("schools","school_name",:string,:limit=>30,:null=>false)
    add_column("schools","province",:string,:limit=>20)
    add_column("schools","city",:string,:limit=>20,:null=>false)
    add_column("schools","pic",:string,:limit=>255)
    add_column("schools","status",:string , :limit => 10,:null=>false)
  end

  def down
    remove_column("schools","status")
    remove_column("schools","pic")
    remove_column("schools","city")
    remove_column("schools","province")
    remove_column("schools","school_name")
  end
end
