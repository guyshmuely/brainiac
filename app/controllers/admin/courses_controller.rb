class Admin::CoursesController < ApplicationController

  def index
    @courses = Course.all
  end

  def show

  end

  def new
    @course = Course.new
  end

  def create
    course = Course.create params[:course]
    redirect_to :action=>:index
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    @course.update_attributes(params[:course])
    redirect_to :action=>:index
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to :action=>:index
  end

end
