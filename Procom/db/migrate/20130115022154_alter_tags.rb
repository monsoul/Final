class AlterTags < ActiveRecord::Migration
  def up
    add_column("tags","name",:string,:limit=>30,:null=>false)
  end

  def down
    remove_column("tags","name")
  end
end
