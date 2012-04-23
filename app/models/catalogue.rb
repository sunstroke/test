class Catalogue < ActiveRecord::Base
acts_as_list  
  mount_uploader :foto1, ItemUploader
  mount_uploader :foto2, ItemUploader
  mount_uploader :foto3, ItemUploader    
end
