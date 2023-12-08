require 'blog_post' # Add the missing import statement

class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :set_blog_post, except: [:index, :new, :create]

  
  def index
    if user_signed_in?
    @blog_posts = BlogPost.all
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end

  def new
    if user_signed_in?
    @blog_post = BlogPost.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end

    else
      redirect_to new_user_session_path
    end
  end

  def edit
    if user_signed_in?
    @blog_post = BlogPost.find(params[:id])
    else
      redirect_to new_user_session_path
    end
  end

  def update 
    if user_signed_in?
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end

    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    if
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end
  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path
    end
  end
end
