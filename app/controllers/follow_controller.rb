class FollowController < ApplicationController
    def create
        # create a new follow with the logged in user as follower and the selected as followee
        follow = Follow.new
        follow.follower = params[:id];
        follow.followee = params[:followee];

        if follow.save
            # if we manage to save the follow we inform the view with a notice
            flash[:notice]= "Followed user #{User.find(params[:followee]).email}!"
        else
            # if follow can't be saved due to restrictions of uniqueness we inform the view with an alert 
            flash[:alert]= "Unable to follow user!"
        end
        # we need to stay to the same view
        redirect_to show_users_path(params[:id])
    end

     
  def destroy
    # get the logged in user
    user = User.find(params[:id])
    # get the follow records that the logged in user 
    follow = Follow.where(follower: params[:id], followee: params[:followee])
    # for each followee id find the user in order to inform the view with info message and then delete the record
    follow.each do |f|
        user = User.find(f.followee)
        if f.destroy 
            flash[:notice]= "User #{user.email} unfollowed!"
        end
    end

    redirect_to show_users_path(params[:id])
  end

end
  