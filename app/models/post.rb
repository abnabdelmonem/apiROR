class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :message,
            presence: true,
            length: { maximum: 350 }
  
  enum published: %i[published unpublished].freeze
  
  private

    def self.set_avaliable_posts(current_user_status)
      if current_user_status["aud"] == ["admin"]
        @posts = Post.all
      else
        @posts = Post.where(published:0).or(Post.where(user_id: current_user_status["user_id"]))
      end
    end

    def self.avaliable_to_show(post_id,current_user_status) #user can see his own posts admin can see all
      @post = Post.find(post_id)

      user_status = current_user_status

      if @post.user_id == user_status["user_id"] || user_status["aud"] == ["admin"] || @post.published == "published"
        @post
      else
        nil
      end

    end

    def self.avaliable_to_update(post_id,current_user_status) #user only can update his posts
      @post = Post.find(post_id)
      if @post.user_id == current_user_status["user_id"]
        @post
      else
        nil
      end
    end

    def self.avaliable_to_delete(post_id, current_user_status)
      user_role = current_user_status["aud"]

      if user_role == ["admin"]
        @post = Post.find(post_id)
      else
        nil
      end
    end

end
