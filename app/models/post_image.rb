class PostImage < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :post_comments,dependent: :destroy
  has_many :favorites, dependent: :destroy

  # shop_nameが存在しているかを確認するバリデーション
  validates :shop_name, presence: true
  # imageが存在しているかを確認するバリデーション
  validates :image, presence:true
  validates :address,presence: true

  #  addressカラムの内容を緯度経度に変換する
  geocoded_by :address
  # バリデーション実行後に変換処理を実行して、latitudeカラムとlongitudeカラムに緯度経度の値が入力される
  after_validation :geocode

   def get_image
    unless image.attached?
      file_path=Rails.root.join("app/assets/images/no_image.jpg")
      image.attach(io:File.open(file_path), filename: "default-image.jpg",content_type: "image/jpeg")
    end
      image
    end 

    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end  
  
end
