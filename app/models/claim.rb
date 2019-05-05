class Claim < ApplicationRecord
  belongs_to :user
  belongs_to :src, required: false
  belongs_to :medium, required: false
  has_many :claim_reviews

  validates :title, presence: true
  validates :has_image, presence: true
  validates :has_video, presence: true
  validates :has_text, presence: true
  validates :sharing_mode, presence: true

  attr_accessor :sharing_mode

    def medium_name
      medium.try(:name)
    end

    def medium_name=(name)
      self.medium = Medium.create_with(user_id: User.current_user.id).find_or_create_by(name: name) if name.present?
      self.medium.update(sharing_mode: 1)
    end

    def src_name
      src.try(:name)
    end

    def src_name=(name)
      self.src = Src.create_with(user_id: User.current_user.id).find_or_create_by(name: name) if name.present?
      self.src.update(sharing_mode: 1)
    end

  end
