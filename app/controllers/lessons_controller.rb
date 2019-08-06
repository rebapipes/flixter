class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson.section.course, only: [:show]

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current.section.lessons.create(lesson_params)
    redirection_to instructor_course_path(current_section.course)
  end
  
  def show
  end

  private

  def require_authorized_for_current_lesson.section.course
    if current_user.enrolled_in? != current_user
      redirect_to course_enrollments_path, alert: 'You must be enrolled in the course to view this page'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end