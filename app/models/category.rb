class Category < ActiveRecord::Base
  has_many :catalogues, :class_name => "catalogue"
end
