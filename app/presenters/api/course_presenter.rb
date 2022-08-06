class Api::CoursePresenter
  def initialize object
    @object = object
  end

  def format_response
    @object.map { |course|  course_info course["attributes"] }
  end

  private

  def course_info course_attributes
    {
      name: course_attributes["name"],
      url: course_attributes["url"]
    }
  end
end
