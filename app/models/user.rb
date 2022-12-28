# frozen_string_literal: true

class User < ApplicationRecord
  has_one :approval,  dependent: :destroy
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
  validate :validate_files_content_type, on: :update

  after_create :notify_user

  def notify_user
    VerificationMailer.notify_to_complete_profile(self, self.password).deliver_now
  end

  def must_be_valid_date
    if dob.nil?
      errors.add(:dob, 'Date of Birth was not provided!')
    elsif dob >= Date.today
      errors.add(:dob, 'Invalid date of birth!(can not be in future)')
    end
  end

  def validate_files_content_type
    validate_img_content_type(profile_picture)
    validate_img_content_type(cnic_picture)
    validate_file_content_type(dob_file)
    validate_file_content_type(domicile_file)
  end

  def validate_img_content_type(element)
    return unless element.attached?
    allowed_content_types = ['image/png', 'image/jpeg', 'image/jpg','image/gif']
    unless allowed_content_types.include?(element.content_type)
      errors.add(:profile_and_cnic_picture, 'must be a PNG, JPEG, GIF, or JPG image')
    end
  end

  def validate_file_content_type(element)
    return unless element.attached?
    allowed_content_types = ['application/pdf', 'application/msword','application/vnd.oasis.opendocument.text', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/x-ole-storage']
    unless allowed_content_types.include?(element.content_type)
      errors.add(:birth_certificate_and_domicile_file, 'must be a PDF, DOC, ODT or DOCX file')
    end
  end

  enum role:
  {
    'non-supervisor': 0,
    supervisor: 1
  }
end