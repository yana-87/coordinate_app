class Coordinate < ApplicationRecord
  has_one_attached :image
  validates :image, presence: { message: "画像を選択してください"}
end
