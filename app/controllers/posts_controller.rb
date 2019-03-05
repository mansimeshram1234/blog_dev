class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]


	def index
		if params[:tag]
      @posts = Post.tagged_with(params[:tag])
     @tags_posts_count=Tagging.group("taggings.tag_id").count


   else
   
		@posts=Post.all.order('created_at DESC')
		
		@post=Post.order('updated_at DESC')
	end
	
	end

	def new 
		@post=Post.new
		
	end

	def create 
		@post = Post.new(post_update_params)

		if @post.save
		redirect_to @post
	   else 
	   	render 'new'

    end
end

	def show

	  	@post=Post.find(params[:id])
    end 
   def edit
    @post=Post.find(params[:id])
   end

def update

	 @post=Post.find(params[:id])
    
	 if @post.update(post_params)
	 	redirect_to @post
	 else 
	 	render 'edit'
	 end
end

def destroy
	@post=Post.find(params[:id])
	@post.destroy
	redirect_to root_path
	end

    private

    def post_params

    	params[:post][:user_id]=@post.user_id
    	params.require(:post).permit(:title, :body,:user_id,:published)
    end

    def post_update_params

    	params[:post][:user_id]=current_user.id
         params.require(:post).permit(:title, :body, :user_id,:published)
     end
end
