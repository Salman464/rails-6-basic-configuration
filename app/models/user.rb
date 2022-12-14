class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable,:confirmable
  validates :first_name, :cnic, :contact, :dob, :address, presence: true
  validates :cnic, :contact, numericality: { only_integer: true }
  validate :must_be_valid_date

  def must_be_valid_date
    if dob >= Date.today
      errors.add(:dob, "Invalid date of birth!(must be less than today)")
    end
  end
end
