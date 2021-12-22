class Token < ApplicationRecord
  belongs_to :user

  validates :token, :expires_at, :user_id, presence: true

  after_initialize do
    loop do
      self.token = SecureRandom.hex
      break unless Token.where(token: token).any?
    end

    self.expires_at ||= 2.hours.from_now
  end
end
