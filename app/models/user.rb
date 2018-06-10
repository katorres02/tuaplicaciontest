class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true

  has_many :interests, dependent: :destroy

  before_create :set_token


  private
  	# asigna un token de autenticacion al momento de la creación del usuario
  	def set_token
  		self.authentication_token = Devise.friendly_token
  	end
end
