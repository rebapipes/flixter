class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current.section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end
  
  def show
  end

  private

  def require_authorized_for_current_lesson
    unless current_user.enrolled_in?(current_lesson.course)
      redirect_to course_path, alert: 'You must be enrolled in the course to view this page',
      course_id: current_lesson.section.course.id
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end