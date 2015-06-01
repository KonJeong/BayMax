class Product < ActiveRecord::Base
	has_attached_file :picture, :default_url => "/app/assets/images/test_picture.JPG"
	validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
