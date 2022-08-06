class CoursesController < ApplicationController
  def index
    uri = URI('https://open.hpi.de/bridges/moochub/courses')
    
    begin
      response = Net::HTTP.get(uri)
      @courses = JSON.parse(response)["data"]
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => error
      redirect_to courses_path
      # Handle error message
    end
  end
end
