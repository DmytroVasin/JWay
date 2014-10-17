class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :swich_state]

  def index
    @posts = Post.available_for(current_user).sort_by_date.page(params[:page]).per(10)
    @posts = @posts.eager_load(:tags)
    find_tags
  end

  def show
    @relative_posts = Post.limit_rand(5)
    @tags = @post.tags
  end

  def new
    @post = Post.new
    find_tags
  end

  def create
    @post = Post.new(Post.reject_blank_tags(post_params))
    if @post.save
      redirect_to post_path(@post), notice: 'Post is successfully created!'
    else
      find_tags
      render :new
    end
  end

  def edit
    find_tags
    render :new
  end

  def update
    if @post.update_attributes!(post_params)
      redirect_to post_path(@post), notice: 'Post is successfully updated!'
    else
      render :edit
    end
  end

  def swich_state
    @post.update_state(swich_params[:state])

    render nothing: true
  end

  private

  def find_post
   @post = Post.available_for(current_user).find(params[:id])

   redirect_to root_path, alert: 'Post not find!' unless @post
  end

  def post_params
    params.require(:post).permit( :title, :meta, :body, :body_title, :title_img, :original, :status, tag_ids: [] )
  end

  def swich_params
    params.permit( :id, :state )
  end
end
