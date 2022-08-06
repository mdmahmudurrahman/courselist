require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "request list of all courses" do
    it "successfully renders the courses index as root path" do
      get root_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end
end
