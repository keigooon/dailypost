class User < ApplicationRecord

  before_save { self.email.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence:true, length: {maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 200}
  mount_uploader :profile_image, ImageUploader
  has_secure_password
  
  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(a_post)
    self.likes.find_or_create_by(post_id: a_post.id)
  end
  
  def remove_like(a_post)
    like = self.likes.find_by(post_id: a_post.id)
    like.destroy if like
  end
  
  def like?(a_post)
    self.like_posts.include?(a_post)
  end
end