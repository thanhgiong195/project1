class Authorpost < ApplicationRecord
  belongs_to :user

  scope :feed_sort, ->{order created_at: :desc}
  scope :load_feed, ->id{where "user_id = ?", id}

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.authorpost.content_size}
  validate :picture_size

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
