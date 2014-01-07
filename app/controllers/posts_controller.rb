class PostsController < ApplicationController
	before_action :authenticate_user, only: [ :create, :index, :destroy]

	def index
		@posts=Post.from_followed_users(current_user).page(params[:page]).order('created_at DESC')
		@post = current_user.posts.build
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(create_params)
		if @post.save
			flash[:success] = "Post Successfully"
			redirect_to root_path
		else
			render "new"
		end
	end

	def destroy
		@post= Post.find(params[:id])
		if current_user?(@post.user)
			@post.destroy
			flash[:success] = "Post deleted"
			redirect_to posts_path
		else
			flash[:error] ="You cannot delete that post"
			redirect_to posts_path
		end
	end

	private
	def create_params
		params.require(:post).permit(:content)
	end
end
