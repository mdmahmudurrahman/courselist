class CoursesController < ApplicationController
  def index
    # Base url can be obtained from ENV variable
    # API wrapper could be used here to make the external API call
    uri = URI('https://open.hpi.de/bridges/moochub/courses')

    begin
      response = Net::HTTP.get(uri)
      @response = JSON.parse(response)["data"]
      @courses = Api::CoursePresenter.new(@response).format_response
      @courses = Kaminari.paginate_array(@courses).page(params[:page])
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => error
      redirect_to courses_path
      # Handle error message
    end
  end
end
