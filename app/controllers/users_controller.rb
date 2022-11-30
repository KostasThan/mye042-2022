class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.valid?
    if !@user.is_email?
      flash[:alert] = "Input a properly formatted email."
      redirect_to :back
    elsif @user.errors.messages[:email] != nil
      flash[:notice]= "That email " + @user.errors.messages[:email].first
      redirect_to :back
    elsif @user.save
      flash[:notice]= "Signup successful. Welcome to the site!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:alert] = "There was a problem creating your account. Please try again."
      redirect_to :back
    end
  end

  def new
  end

  def show
    # all registered users
    @users = User.all
    # logged in user
    @user = User.find(params[:id])
    # Follow records that logged in user is the follower
    follow = Follow.where(follower: params[:id])
    
    # a set of user_ids that the logged in user follows
    followees = Set[]
    follow.each do |f|
      followees.add(f.followee)
    end

    # get all the users that the logged in user follows
    followedUsers = User.find(followees.to_a.flatten)

    # this instance variable has all the photos tha must be displayed for a logged in user
    @allPhotos = []

    # photos that the logged in user has uploaded
    @user.photos.each do |uphd|
      @allPhotos.append(uphd)
    end

    # photos that the followees of the logged in user has updloaded
    followedUsers.each do |followedUser|
      followedUser.photos.each do |phd|
        @allPhotos.append(phd)
      end
    end
  
    # all photos sorted by created_at field by ascending order
    @allPhotos = @allPhotos.sort { |a,b| a.created_at <=> b.created_at }

    @allPhotos.each do |ph|
      puts "photo after sort #{ph.created_at}"
    end

    # we reverse it to get the descending orger
    @allPhotos = @allPhotos.reverse

    @allPhotos.each do |ph|
      puts "photo after reverde #{ph.created_at}"
    end

    # have comment ans tag ready to be used
    @comment = Comment.new
    @tag = Tag.new
  end

  def index
    #find all the users
    @users = User.all

    #find the logged in user
    @user = User.find(params[:id])

    # get the Follow records in which the logged in user is the follower
    follow = Follow.where(follower: params[:id])

    # Aaset of user_ids that the logged in user follows
    followees = Set[]
    follow.each do |f|
      followees.add(f.followee)
    end

    # instance variable used in order for the view to display the follow or the unfollow button
    @followedUsers = followees.to_a
    
    # set to users all the user except the logged in one, no reason to follow myself
    @users = @users - [@user]

  end

  private
  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
  end


end
