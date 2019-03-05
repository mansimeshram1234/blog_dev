class CommentsController < ApplicationController
	before_action :authenticate_user!
	def create 
		@post=Post.find(params[:post_id])
		@comment= @post.comments.create(params[:comment].permit(:name, :body))

		 if @comment.save
		
      flash[:success] = 'Comment posted.'

      	respond_to do |format|
      		format.html { redirect_to post_path(@post) }
      		format.js #render comments/create.js.erb
		
	end
	end 
end



    def mycomment
    	@comment=Comment.find(params[:comment_id])
    	@com=@comment.comments.create(com_params)
    	redirect_to posts_path
    end
	def destroy 
		@post = Post.find(params[:post_id])
		@comment=@post.comments.find(params[:id])
		@comment.destroy
		
		flash[:success] = 'Comment deleted.'
		redirect_to post_path(@post)
        end


	private
	def com_params
		params[:comment][:commentable_type]="Comment"
		params.require(:comment).permit(:body,:comment_id,:commentable_type)
	end
end
