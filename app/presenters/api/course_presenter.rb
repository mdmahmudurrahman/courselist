class Api::CoursePresenter
  def initialize object
    @object = object
  end

  def format_response
    @object.map { |course|  as_json course["attributes"] }
  end

  private

  def as_json course_attributes
    {
      name: course_attributes["name"],
      url: course_attributes["url"]
    }
  end
end
