class AddAttachmentPictureToDeals < ActiveRecord::Migration
  def self.up
    change_table :deals do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :deals, :picture
  end
end
