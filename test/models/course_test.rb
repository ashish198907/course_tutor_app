require "./test/test_helper"

class CourseTest < ActiveSupport::TestCase
  test 'valid course' do
    course = Course.new(name: 'Course for Test', description: 'test description', duration: "2 weeks")
    assert course.valid?
  end

  test 'invalid without name' do
    course = Course.new(description: 'test description', duration: "2 weeks")
    refute course.valid?
    assert_not_nil course.errors[:name]
  end

  test 'invalid with existing name' do
    course = Course.new(name: courses(:course_one).name, description: 'test description', duration: "2 weeks")
    refute course.valid?
    assert_not_nil course.errors[:name]
  end

  test 'invalid without description' do
    course = Course.new(name: 'Course for Test', duration: "2 weeks")
    refute course.valid?
    assert_not_nil course.errors[:description]
  end

  test 'invalid without duration' do
    course = Course.new(name: 'Course for Test', description: 'test description')
    refute course.valid?
    assert_not_nil course.errors[:duration]
  end
end
