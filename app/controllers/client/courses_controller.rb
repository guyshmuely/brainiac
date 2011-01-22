class Client::CoursesController < ApplicationController

  layout 'course'

  def show
    @course = Course.find(params[:id])
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
