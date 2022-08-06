class CoursesController < ApplicationController
  def index
    # Base url can be obtained from ENV variable
    # API wrapper could be used here to make the external API call
    cache_id = params[:page].nil? ? 1 : params[:page] 
    begin
      @courses = Rails.cache.fetch("cached_courses_#{cache_id}", expires_in: 1.minutes) do
        uri = URI('https://open.hpi.de/bridges/moochub/courses')
        response = Net::HTTP.get(uri)
        @response = JSON.parse(response)["data"].nil? ? [] : JSON.parse(response)["data"]
        @courses = Api::CoursePresenter.new(@response).format_response
        @courses = Kaminari.paginate_array(@courses).page(params[:page])
      end
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => error
      redirect_to root_path
      # Handle error message
    end
  end
end
