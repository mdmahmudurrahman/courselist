require "rails_helper"

describe Api::CoursePresenter do
  let(:empty_object){Api::CoursePresenter.new []}
  let(:courses_object){ Api::CoursePresenter.new [ 
      { "type": "courses",
        "attributes" => { 
        "name" => "name 1", "url" => "https://example.com/", "courseMode" => "MOOC" 
        }
      }
    ]
  }

  describe "#courses" do
    it "should return []" do
      expect(empty_object.format_response).to be_empty
    end

    it "should return courses" do
      expect(courses_object.format_response).to be_instance_of Array
      expect(courses_object.format_response.size).to eq 1
      expect(courses_object.format_response[0].has_key? :name).to be true 
      expect(courses_object.format_response[0].has_key? :courseMode).to be false 
    end
  end
end
