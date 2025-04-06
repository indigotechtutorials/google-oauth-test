class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one_attached :avatar

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(email_address: data['email']).first

      # Uncomment the section below if you want users to be created if they don't exist
      unless user
        user = User.create(
            first_name: data['first_name'],
            last_name: data['last_name'],
            email_address: data['email'],
            password: SecureRandom.hex
        )

        if data['image']
          user.avatar.attach(io: URI.open(data['image']), filename: "avatar.jpg")
        end
      end
      user
  end
end
