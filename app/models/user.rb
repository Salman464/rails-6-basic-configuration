# frozen_string_literal: true

class User < ApplicationRecord
  has_one :approval
  has_one_attached :profile_picture
  has_one_attached :cnic_picture
  has_one_attached :dob_file
  has_one_attached :domicile_file

  # Include default devise modules. Others available are:
  # :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :confirmable

  validates :first_name, :cnic, :contact, :dob, :address, :gender, presence: true, on: :update
  validates :cnic, numericality: { only_integer: true }, on: :update
  validates :cnic, length: { is: 13 }, on: :update
  validates :cnic, uniqueness: true, on: :update
  validates :contact, phone: true, on: :update
  validate :must_be_valid_date, on: :update
  validates_presence_of :profile_picture, :cnic_picture, :dob_file, :domicile_file, on: :update

  def must_be_valid_date
    if dob.nil?
      errors.add(:dob, 'Date of Birth was not provided!')
      return false
    end

    if dob >= Date.today
      errors.add(:dob, 'Invalid date of birth!(can not be in future)')
      return false
    end
    true
  end

  enum role:
  {
    'non-supervisor': 0,
    supervisor: 1
  }
end
