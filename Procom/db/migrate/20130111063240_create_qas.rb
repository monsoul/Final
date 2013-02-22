class CreateQas < ActiveRecord::Migration
  def change
    create_table :qas do |t|

      t.timestamps
    end
  end
end
