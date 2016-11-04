class User < ActiveRecord::Base
  has_many :repos, dependent: :destroy
  has_many :scans
  has_many :issues
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]
  validates :access_token, length: { is: 40,
    wrong_length: "You entered %{count} characters, access tokens are 40 characters"  }

  after_destroy { |record|
    Repo.destroy(record.repos.pluck(:id))
  }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
