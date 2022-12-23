class Comment < ActiveRecord::Base

    #a comment is written by a user, under a photo
    belongs_to :user
    belongs_to :photo

    #before saving to db make sure a comment has text and at least one letter
    validates :text, presence: true, allow_blank: false 
end
