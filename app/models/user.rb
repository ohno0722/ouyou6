class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 validates :name, presence: true, uniqueness: true,length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }


  has_many :books,  dependent: :destroy
  has_one_attached :profile_image
  
  has_many :book_comments, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy


  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # フォローしたときの処理
  def follow(user_id)
  relationships.create(followed_id: user_id)
  end
# フォローを外すときの処理
  def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
  end
# フォローしているか判定
  def following?(user)
  followings.include?(user)
  end
  
end
