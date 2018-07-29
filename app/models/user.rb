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

  def mailboxer_email(obj); end

  def hidden_attributes
    %i[
      created_at
      updated_at
    ]
  end

  def full_name
    'користувач користувач'
  end

  alias name full_name
end
