class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :require_login
  
  # GET /posts
  def index
    @user = User.find_by(id: current_user_status["user_id"])
    if @user.role == "admin"
      render json: Post.all
    else
      render json: @user.posts
    end
  end

  # GET /posts/1
  def show
    render json: @post
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
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])

      user_status = current_user_status

      if (@post.user_id == user_status["user_id"]) && (user_status["aud"] != ["admin"]) 
        @post
      elsif user_status["aud"] == ["admin"]
        @post
      else
        render json: {error: 'Unauthorized'}, status: :unauthorized
      end

    end

    # Only allow a list of trusted parameters through.
    def post_params
      i = current_user_status["user_id"]
      post = {message: params.permit(:message)["message"],user_id: i}
      post
    end
end
