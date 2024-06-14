class TutorsController < ApplicationController
  before_action :set_tutor, only: %i[ show update destroy ]
  before_action :validate_course, only: %i[create update]

  # GET /tutors
  def index
    @tutors = Tutor.all

    render json: @tutors
  end

  # GET /tutors/1
  def show
    render json: @tutor
  end

  # POST /tutors
  def create
    @tutor = Tutor.new(tutor_params)

    if @tutor.save
      render json: @tutor, status: :created, location: @tutor
    else
      render json: @tutor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tutors/1
  def update
    if @tutor.update(tutor_params)
      render json: @tutor
    else
      render json: @tutor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tutors/1
  def destroy
    @tutor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor
      @tutor = Tutor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tutor_params
      params.require(:tutor).permit(:name, :email, :course_id)
    end

    def validate_course
      unless Course.find_by_id(tutor_params[:course_id])
        render json: {course_id: "Course is invalid. Please assign a valid course_id"}, status: :unprocessable_entity
      end
    end
end
