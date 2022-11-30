class Photo<ActiveRecord::Base
  belongs_to :user
  has_many :tags

  # when a photo is deleted, delete all the comments of the photo as well
  has_many :comments, :dependent => :destroy

  # before saving to the database, make sure a title is there and is not black
  validates :title, presence: true, allow_blank: false 

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
