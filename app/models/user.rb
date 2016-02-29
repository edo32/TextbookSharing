class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :textbooks

  # # Data validation
  validates :name, presence: true
  validates :college, presence: true
  validates :fblink, presence: true

  COLLEGES = ['HMC', 'Scripps', 'Pitzer', 'CMC', 'CGU', 'KGI', 'Pomona']
end
