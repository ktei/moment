class Photo < ActiveRecord::Base
  attr_accessible :description

  belongs_to :album

  has_attached_file :image,
    :styles => { :thumb => ["200x150#", :jpg], :formal => ["800x600^", :jpg] }

  default_scope :order => 'photos.created_at ASC'
end
