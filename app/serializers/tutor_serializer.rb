class TutorSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  belongs_to :course
end
