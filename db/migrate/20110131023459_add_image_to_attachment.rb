class AddImageToAttachment < ActiveRecord::Migration
  def self.up
    add_column :attachments, :image, :string
  end

  def self.down
    remove_column :attachments, :image
  end
end
