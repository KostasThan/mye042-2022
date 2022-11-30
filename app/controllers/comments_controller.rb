class CommentsController < ApplicationController
    def new
        redirect_to "/"
      end
    
      def create
       
        #create the new comment
        @comment = Comment.new
        @comment.photo_id = params[:comment][:photo_id]
        @comment.user_id = params[:comment][:user_id]
        @comment.text = params[:comment][:text]
        
        
        #if we manage to save it to db
        if @comment.save
          flash[:notice] = "Comment sucessfuly added"
        else
          flash[:alert] = "Couldn't add your comment"
        end

        redirect_to user_path(session[:user_id])
      end

      def destroy
        #find comment from the db
        @comment = Comment.find(params[:id])

        #find the user from the db
        #here we retrieve the user from the session not the one that has written the comment
        @user =  User.find(session[:user_id])

        #only if the comment is of the logged in user
        if @comment.user_id == @user.id
          #delete the comment
          @comment.destroy
          flash[:notice] = "Comment was deleted!"
        else
          flash[:alert] = "You can only delete your own comments"
        end

        #redirect to the user
        redirect_to user_path(@user)
      end
end
