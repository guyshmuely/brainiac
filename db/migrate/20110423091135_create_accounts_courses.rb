class CreateAccountsCourses < ActiveRecord::Migration
  def self.up
    create_table(:accounts_courses, :id => false) do |t|
      t.integer :account_id, :course_id
    end
  end

  def self.down
    drop_table :accounts_courses
  end
end
