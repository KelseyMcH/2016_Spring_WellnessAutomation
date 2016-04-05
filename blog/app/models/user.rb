class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_secure_password
  validates :password, length: { in: 6..20 }
  has_many :actions
  belongs_to :department
end
