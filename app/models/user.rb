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
  has_many :imagevotes, foreign_key: "voted_id"
  has_many :imagevotes, foreign_key: "voter_id"
  validates :username, presence: true,
                       length: { maximum: 15 },
                       uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  before_destroy :set_gold_and_silver


  def to_param
    username
  end

  def painterscore
    gold = self.collections.where(:is_gold => true).count * 25
    silver = self.collections.where(:is_silver => true).count * 10
    totalvotes = self.vote_count
    gold+silver+totalvotes
  end

  def set_gold_and_silver
    @miniatures = self.imagevotes.map(&:miniature).uniq
    self.imagevotes.destroy
    @miniatures.each(&:set_gold_and_silver)
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