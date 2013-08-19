class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :avatar, :name

  has_many :albums, :dependent => :destroy

  validates :name, 
    :length =>  { :maximum => 50 }

  has_attached_file :avatar,
    :styles => { :profile => ["200x180#", :jpg], :thumb => ["40x40#", :jpg] }

  def alias
    return self.email.split('@').first if self.name.blank?
    self.name
  end
end
