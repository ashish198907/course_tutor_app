class Course < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :description, :duration, presence: true
  has_many :tutors, dependent: :destroy

  accepts_nested_attributes_for :tutors
end
