class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :duration
  has_many :tutors
end
