require "../spec_helper"

describe Crest do
  describe "Basic Auth" do
    context Crest::Request do
      it "should be unsuccessful without credentials" do
        expect_raises Crest::RequestFailed, "HTTP status code 401" do
          response = Crest::Request.execute(:get, "#{TEST_SERVER_URL}/secret", user: "root", password: "qwerty")
        end
      end

      it "should be successful with valid credentials" do
        response = Crest::Request.execute(:get, "#{TEST_SERVER_URL}/secret", user: "username", password: "password")
        (response.status_code).should eq(200)
        (response.body).should eq("Secret World!")
      end

      it "should be unsuccessful with invalid credentials" do
        expect_raises Crest::RequestFailed, "HTTP status code 401" do
          response = Crest::Request.execute(:get, "#{TEST_SERVER_URL}/secret", user: "root", password: "qwerty")
        end
      end
    end

    context Crest do
      it "should be successful with valid credentials" do
        response = Crest.get("#{TEST_SERVER_URL}/secret", user: "username", password: "password")
        (response.status_code).should eq(200)
        (response.body).should eq("Secret World!")
      end
    end

    context Crest::Resource do
      it "should be successful with valid credentials" do
        resource = Crest::Resource.new("#{TEST_SERVER_URL}/secret", user: "username", password: "password")
        response = resource.get
        (response.status_code).should eq(200)
        (response.body).should eq("Secret World!")
      end
    end
  end
end