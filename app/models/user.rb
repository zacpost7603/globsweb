class User < ApplicationRecord
    has_many :globs
    has_secure_password
    
    validates :name, presence: true
    validates :email, format: {with: /@/, messaage: "must have an @"}, uniqueness: true
    
    before_create {generate_token(:auth_token)}
    
    def self.new_from_hash(user_hash)
        user = User.new user_hash
        user.password_digest = 0
        user
    end
    
    def has_password?
        self.password_digest.nil? || self.password_digest != '0'
    end
    
    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.zone.now
        save!
        UserMailer.password_reset(self).deliver
    end
    
    def generate_token(column)
        begin
            self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
    end
end
