class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:user, :admin]
  devise :database_authenticatable, :registerable, :confirmable,
          :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable
end
