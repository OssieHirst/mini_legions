class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :collections, dependent: :destroy
  has_many :miniatures, through: :collections
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :paintingvotes, foreign_key: "recipient_id", dependent: :destroy
  has_many :reverse_paintingvotes, foreign_key: "voter_id", dependent: :destroy
  validates :username, presence: true,
                       length: { maximum: 15 },
                       uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  letsrate_rater


  def to_param
    username
  end

  def add!(miniature)
    collections.create!(miniature_id: miniature.id)
  end

  def remove!(miniature)
    collections.find_by(miniature_id: miniature.id).destroy!
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end


end