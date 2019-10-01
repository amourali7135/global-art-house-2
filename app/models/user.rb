class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  has_one :artist
  has_many :comments
  
  acts_as_follower
  acts_as_liker
  acts_as_mentioner

  
  attr_writer :login
  
  def login
    @login || self.username || self.email
  end
  
  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   elsif conditions.has_key?(:username) || conditions.has_key?(:email)
  #     where(conditions.to_h).first
  #   else
  #     conditions[:email].downcase! if conditions[:email]
  #     where(conditions.to_h).first
  #   end
  
  
  
  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
    ["lower(username) = :value OR lower(email) = :value",
    { value: login.strip.downcase}]).first
  end
  
  
  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
end

