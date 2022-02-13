class PostsController < ApplicationController
  before_action :require_login
  
  # GET /posts
  def index
    @posts = Post.set_avaliable_posts(current_user_status)
    render json: @posts
  end

  # GET /posts/1
  def show
    @post = Post.avaliable_to_show(params[:id],current_user_status)
    if @post.nil?
      render json: {error: 'you have no access to this post'}, status: :unauthorized
    else
      render json: @post
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post = Post.avaliable_to_update(params[:id],current_user_status)
    if @post.nil?
      render json: {error: 'only owner can update this post'}, status: :unauthorized
    else
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.avaliable_to_delete(params[:id],current_user_status)
    if @post.nil?
      render json: {error: 'only admin can delete a post'}, status: :unauthorized
    else
      @post.destroy
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def post_params
      i = current_user_status["user_id"]
      post = {message: params.permit(:message)["message"],user_id: i}
      post
    end
end
