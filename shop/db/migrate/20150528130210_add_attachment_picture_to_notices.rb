class AddAttachmentPictureToNotices < ActiveRecord::Migration
  def self.up
    change_table :notices do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :notices, :picture
  end
end
