class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.integer :course_id
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
