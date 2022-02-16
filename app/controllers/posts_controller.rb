class PostsController < ApplicationController
  before_action :require_login
  before_action :find_post, except: [:index, :create]
  
  # GET /posts
  def index
    @posts = policy_scope(Post)
    render json: @posts
  end

  # GET /posts/1
  def show
    authorize @post
    render json: @post, include: ['comments', 'comments.replies']
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.save!
    render json: @post
  end

  # PATCH/PUT /posts/1
  def update
    authorize @post
    @post.update!(post_params)
    render json: @post
  end

  # DELETE /posts/1
  def destroy
    authorize @post
    @post.destroy
  end

  private
    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:message).merge(user_id: @user.id)
    end

    def find_post
      @post = Post.find(params[:id])
    end
end
