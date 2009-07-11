class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :download_file_name
      t.string :download_content_type
      t.integer :download_size
      t.datetime :download_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
