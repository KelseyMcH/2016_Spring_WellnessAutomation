class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_secure_password
  validates :password, length: { in: 6..20 }
  has_many :actions
  belongs_to :department
  before_create :confirmation_token
  attr_accessor :reset_password_token

  def email_activate
      self.email_confirmed = true
      self.confirm_token = nil
      save!(:validate => false)
   end

def create_reset_digest
    update_attribute(:reset_password_token, SecureRandom.urlsafe_base64.to_s)
    update_attribute(:reset_password_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  private
  	
	def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end
