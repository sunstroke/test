class Catalogue < ActiveRecord::Base
  mount_uploader :foto1, ItemUploader
  mount_uploader :foto2, ItemUploader
  mount_uploader :foto3, ItemUploader    
end
