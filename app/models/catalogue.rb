class Catalogue < ActiveRecord::Base
  belongs_to :category, :class_name => "Category", :foreign_key => "category_id"
acts_as_list  
  mount_uploader :foto1, ItemUploader
  mount_uploader :foto2, ItemUploader
  mount_uploader :foto3, ItemUploader    
end
