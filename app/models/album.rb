class Album < ActiveRecord::Base
  attr_accessible :title, :description

  belongs_to :user
  has_many :photos, :dependent => :destroy

  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  validates :description, :length => { :maximum => 500 }

  default_scope :order => 'albums.title ASC'
end
