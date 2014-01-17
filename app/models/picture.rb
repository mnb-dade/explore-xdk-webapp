class Picture < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  def self.by_newest
    order('pictures.id DESC')
  end
end
