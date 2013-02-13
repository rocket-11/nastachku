class User < ActiveRecord::Base
  include UserRepository

  has_secure_password

  attr_accessor :password_confirmation
  attr_accessible :email, :password, :password_digest, :password_confirmation,
                  :first_name, :last_name, :city,
                  :company, :position,
                  :show_as_participant, :photo, :state_event, :about

  mount_uploader :photo, UsersPhotoUploader 

  has_many :auth_tokens

  state_machine :state, initial: :active do
    state :active
    state :inactive

    event :activate do
      transition any - :active => :active
    end

    event :deactivate do
      transition :active => :inactive
    end
  end


  def build_auth_token
    token = SecureHelper.generate_token
    expired_at = Time.current + configus.token.lifetime
    auth_tokens.build :authentication_token => token, :expired_at => expired_at
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def to_s
    full_name
  end


end