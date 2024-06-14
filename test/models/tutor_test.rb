require "./test/test_helper"

class TutorTest < ActiveSupport::TestCase
  test 'valid tutor' do
    tutor = Tutor.new(name: 'John', email: 'john@example.com', course: courses(:course_one))
    assert tutor.valid?
  end

  test 'invalid without name' do
    tutor = Tutor.new(email: 'john@example.com')
    refute tutor.valid?
    assert_not_nil tutor.errors[:name]
  end

  test 'invalid without email' do
    tutor = Tutor.new(name: 'John')
    refute tutor.valid?
    assert_not_nil tutor.errors[:email]
  end

  test 'invalid with existing email' do
    tutor = Tutor.new(name: 'John', email: tutors(:tutor_one).email)
    refute tutor.valid?
    assert_not_nil tutor.errors[:email]
  end

  test 'invalid without course' do
    tutor = Tutor.new(name: 'John', email: 'john@example.com')
    refute tutor.valid?
    assert_not_nil tutor.errors[:course]
  end
end
