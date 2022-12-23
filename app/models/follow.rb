class Follow < ActiveRecord::Base
    belongs_to :user
    # make sure that there is no other follower, followee pair in the db
    validates :follower, uniqueness: { scope: [:followee] }
end
