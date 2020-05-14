class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { in: 1...16 }
  validates :fullname, presence: true, length: { in: 1...71 }
  validates :bio, allow_nil: true, length: { in: 1...251 }
  has_many :listings, dependent: :destroy
  has_one_attached :picture
  has_one :cart
  after_create :create_cart

  private
    def create_cart
      Cart.create(user: self)
    end
end
