# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId

  enum role: %i[user admin]
  friendly_id :username, use: :slugged
  devise :database_authenticatable, :registerable, :confirmable,
         :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_one_attached :avatar

  validates :username, uniqueness: {
    case_sensitive: false
  }, allow_nil: true
  validates :username, format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }

  def avatar_path
    avatar.attached? ? avatar : '/assets/profile/user.jpg'
  end

  def mailboxer_email(obj); end

  def hidden_attributes
    %i[
      created_at
      updated_at
    ]
  end

  def full_name
    login
  end

  alias name full_name

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(['username = :value OR email = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      conditions[:email]&.downcase!
      where(conditions.to_hash).first
    end
  end
end
