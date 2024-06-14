require "./test/test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:course_one)
  end

  test "should get index" do
    get courses_url, as: :json
    assert_response :success
  end

  test "should create course" do
    course_name = "Course #{Time.current.to_i}"
    assert_difference("Course.count") do
      post courses_url, params: { course: { description: @course.description, duration: @course.duration, name: course_name } }, as: :json
    end

    assert_response :created
  end

  test "should create course with tutors" do
    course_name = "Course #{Time.current.to_i}"
    assert_difference("Course.count") do
      post courses_url, params: {
        course: {
          description: @course.description,
          duration: @course.duration,
          name: course_name,
          tutors_attributes: [
            { name: "tutor test", email: "tutortest@test.com"}
          ]
        }
      }, as: :json
    end

    assert_response :created
    assert_equal JSON.parse(response.body)["tutors"].count, 1
    assert_equal JSON.parse(response.body)["tutors"][0]["email"], "tutortest@test.com"
   end

  # Validations - presence check
  test "should not create course - presence check" do
    post courses_url, params: { course: { description: nil, duration: nil, name: nil } }, as: :json

    assert_response :unprocessable_entity
    response_data = JSON.parse(response.body)
    expected_errors = {"name"=>["can't be blank"], "description"=>["can't be blank"], "duration"=>["can't be blank"]}
    assert_equal response_data, expected_errors
  end

  # Validations - name uniqueness check
  test "should not create course - uniqueness check" do
    post courses_url, params: { course: { description: @course.description, duration: @course.duration, name: @course.name } }, as: :json

    assert_response :unprocessable_entity
    response_data = JSON.parse(response.body)
    expected_errors = {"name"=>["has already been taken"]}
    assert_equal response_data, expected_errors
  end

  # Validations - tutor email uniqueness check
  test "should not create course - tutor email uniqueness check" do
    course_name = "Course #{Time.current.to_i}"
    post courses_url, params: {
      course: {
        description: @course.description,
        duration: @course.duration,
        name: course_name,
        tutors_attributes: [
          { name: tutors(:tutor_one).name, email: tutors(:tutor_one).email}
        ]
      }
    }, as: :json

    assert_response :unprocessable_entity
    response_data = JSON.parse(response.body)
    expected_errors = {"tutors.email"=>["has already been taken"]}
    assert_equal response_data, expected_errors
  end

  test "should show course" do
    get course_url(@course), as: :json
    assert_response :success

    response_data = JSON.parse(response.body)
    assert_equal 2, response_data["tutors"].count
  end

  test "should update course" do
    patch course_url(@course), params: { course: { description: @course.description, duration: @course.duration, name: @course.name } }, as: :json
    assert_response :success
  end

  test "should destroy course" do
    assert_difference("Course.count", -1) do
      delete course_url(@course), as: :json
    end

    assert_response :no_content
  end
end
