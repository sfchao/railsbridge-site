class FixAttributeNameOnProjects < ActiveRecord::Migration
  def self.up
    rename_column :projects, :site_image_updated_ad, :site_image_updated_at
  end

  def self.down
    rename_column :projects, :site_image_updated_at, :site_image_updated_ad
  end
end
