class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
