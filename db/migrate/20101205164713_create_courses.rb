class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :display_name, :title, :image_file_name, :image_content_type, :icon_file_name, :icon_content_type
      t.integer :image_file_size, :icon_file_size, :price_in_cents, :account_id
      t.datetime :image_updated_at, :icon_updated_at
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
