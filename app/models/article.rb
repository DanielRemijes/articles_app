class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many_attached :pictures
  has_rich_text :body

  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true

  def image_as_thumbnail
    image.variant(resize_to_limit: [300,300]).processed
  end
  def pictures_as_thumbnails
    pictures.map do |picture|
      picture.variant(resize_to_limit: [200,200]).processed
    end
  end
end
