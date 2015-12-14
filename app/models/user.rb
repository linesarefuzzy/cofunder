class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def get_full_name
    if self.first_name && self.last_name
      return (self.first_name + ' ' + self.last_name)
    else
      return 'User'
    end
  end
end
