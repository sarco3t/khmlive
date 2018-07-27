# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: %i[user admin]
  devise :database_authenticatable, :registerable, :confirmable,
         :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all

  def hidden_attributes
    %i[11
      created_at
      updated_at
    ]
  end
end
