class Client::CoursesController < ApplicationController

  before_filter :authenticate_account!
  
  layout 'course'

  def show
    @course = Course.find(params[:id])
    current_account.courses << @course unless current_account.courses.include?(@course)
    respond_to do |format|
      format.html
      format.mobile {}
      format.manifest {
        response.headers['Content-type'] = 'text/cache-manifest'
        render :layout=>false
      }
    end
  end

  def data
    @cards = Course.find(params[:id]).cards
    respond_to do |format|
      format.html
      format.json {
        render :json=> @cards.to_json()
      }      
    end
  end

end
