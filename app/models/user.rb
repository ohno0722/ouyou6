class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 validates :name, presence: true, uniqueness: true,length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }


  has_many :books,  dependent: :destroy
  has_one_attached :profile_image

  has_many :favorites, dependent: :destroy

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

end
