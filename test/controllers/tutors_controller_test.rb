require "./test/test_helper"

class TutorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tutor = tutors(:tutor_one)
  end

  test "should get index" do
    get tutors_url, as: :json
    assert_response :success
  end

  test "should create tutor" do
    tutor_name = "Tutor#{Time.current.to_i}"
    tutor_email = "#{tutor_name}@example.com"
    assert_difference("Tutor.count") do
      post tutors_url, params: { tutor: { course_id: @tutor.course_id, email: tutor_email, name: tutor_name } }, as: :json
    end

    assert_response :created
  end

  # Validations - presence check
  test "should not create tutor - presence check" do
    post tutors_url, params: { tutor: { course_id: @tutor.course_id, email: nil, name: nil } }, as: :json

    assert_response :unprocessable_entity
    response_data = JSON.parse(response.body)
    expected_errors = {"name"=>["can't be blank"], "email"=>["can't be blank"]}
    assert_equal response_data, expected_errors
  end

  # Validations - uniqueness check
  test "should not create tutor - uniqueness check" do
    post tutors_url, params: { tutor: { course_id: @tutor.course_id, email: @tutor.email, name: @tutor.name } }, as: :json

    assert_response :unprocessable_entity
    response_data = JSON.parse(response.body)
    expected_errors = {"email"=>["has already been taken"]}
    assert_equal response_data, expected_errors
  end

  # Validations - course assignment check
  test "should not create tutor - course_id is nil" do
    post tutors_url, params: { tutor: { course_id: nil, email: @tutor.email, name: @tutor.name } }, as: :json

    assert_response :unprocessable_entity
    response_data = JSON.parse(response.body)
    expected_errors = {"course_id"=>"Course is invalid. Please assign a valid course_id"}
    assert_equal response_data, expected_errors
  end

  test "should not create tutor - course_id is invalid" do
    post tutors_url, params: { tutor: { course_id: 1000, email: @tutor.email, name: @tutor.name } }, as: :json

    assert_response :unprocessable_entity
    response_data = JSON.parse(response.body)
    expected_errors = {"course_id"=>"Course is invalid. Please assign a valid course_id"}
    assert_equal response_data, expected_errors
  end

  test "should show tutor" do
    get tutor_url(@tutor), as: :json
    assert_response :success
    response_data = JSON.parse(response.body)
    assert_equal "Course 1", response_data["course"]["name"]
  end

  test "should update tutor" do
    patch tutor_url(@tutor), params: { tutor: { course_id: @tutor.course_id, email: @tutor.email, name: @tutor.name } }, as: :json
    assert_response :success
  end

  test "should destroy tutor" do
    assert_difference("Tutor.count", -1) do
      delete tutor_url(@tutor), as: :json
    end

    assert_response :no_content
  end
end
