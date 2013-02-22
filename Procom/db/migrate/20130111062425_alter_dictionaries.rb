class AlterDictionaries < ActiveRecord::Migration
  def up
    add_column("dictionaries","value_id",:string,:limit=>10,:null=>false)
    add_column("dictionaries","value_content",:string,:limit=>30,:null=>false)
    add_column("dictionaries","value_content_cn",:string,:limit=>30,:null=>false)
    add_column("dictionaries","value_type",:string,:limit=>30,:null=>false)
  end

  def down
    remove_column("dictionaries","value_type")
    remove_column("dictionaries","value_content_cn")
    remove_column("dictionaries","value_content")
    remove_column("dictionaries","value_id")
  end
end
