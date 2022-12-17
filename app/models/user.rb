class User < ApplicationRecord

  has_one_attached :profile_picture
  has_one_attached :cnic_picture
  has_one_attached :dob_file
  has_one_attached :domicile_file
  
  # Include default devise modules. Others available are:
  # :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :confirmable
         
  validates :first_name, :cnic, :contact, :dob, :address, presence: true
  validates :cnic, numericality: { only_integer: true }
  validates :cnic, :email, uniqueness: true
  validates :contact, phone: true
  validate :must_be_valid_date


  def must_be_valid_date
    if dob >= Date.today
      errors.add(:dob, "Invalid date of birth!(must be less than today)")
      return false
    end
    return true
  end
end
