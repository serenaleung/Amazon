class User < ApplicationRecord
  has_secure_password

  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  validates(:first_name, { presence: true })
  validates(:last_name, { presence: true })
  validates(:email, { presence: true, uniqueness: true })

  def generate_api_key
    def generate_api_token
      loop do
        self.api_token =
        SecureRandom.urlsafe_base64(32)
        break unless User.exists?(api_token: self.api_token)
      end
    end
  end

  def self.search(search_term)
    where(['first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?', "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"])
  end

  def self.created_after(date)
    where(['created_at > ?', "#{date}"])
  end

  def self.is_not(name)
    where('first_name != ? AND last_name != ?', "#{name}", "#{name}")
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
