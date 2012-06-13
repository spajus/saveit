require "spec_helper"

describe HomeController do
  it "should render opensearch descriptor" do

    xml_http_request :get, :opensearch
    should render_template('home/opensearch')
  end
  it "should render correct content type" do
    xml_http_request :get, :opensearch
    response.header.should equal('application/opensearchdescription+xml; charset=utf-8')
  end
end