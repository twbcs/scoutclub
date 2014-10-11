class User < ActiveRecord::Base
  after_create :rules
	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :recoverable,
         :registerable, :rememberable, :trackable, :validatable

  has_many :boards
  has_many :posts
  has_many :schedule_attends
  has_many :schedule, :through => :schedule_attends
  has_many :user_groups, :dependent => :destroy
  has_many :groups, :through => :user_groups
  has_one :modifies
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:     auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    auth.info.email,
                         password: Devise.friendly_token[0,20]
                        )
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def rules
    user_count = User.all.count
    if use_count = 1
      user = User.first
      user_rule = Modify.new(:user_id => user.id, :user_rule => 63)
      user_rule.save
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


end
