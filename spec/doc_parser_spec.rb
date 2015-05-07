require 'spec_helper'

def test_definition_content
  it { @definition.get_url.should eql "http://api.sample.com" }
  it { @definition.get_name.should eql "Sample REST API" }
  it { @definition.get_description.should eql "sample description" }
  it { @definition.get_version.should eql "1.0" }
  it { @definition.get_copyright.should eql "2015" }
end

def test_user_resource_content
  subject { @definition.resources['user'].first }
  its(:uri) { should == "/users" }
  its(:action) { should == "GET" }
  its(:headers) { should == { "content_type"=> "application/json" } }
  its(:auth) { should == false }
  its(:params) { should ==
    {"page"=>{"type"=> "integer", "description"=> "Page to show", "required"=> true} }
  }
  its(:description) { should == "Retrieve all the registered users." }
  its(:response) { should ==
    { "data"=> [{ "id"=> 207119551, "first_name"=> "John", "last_name"=> "Doe" }], "total"=> 1050 }
  }
  its(:request){ should ==
    { "email" => "jdoe@gmail.com", "first_name" => "John", "last_name"=> "Doe"}
  }
end

def test_article_resource_content
  subject { @definition.resources['article'].first }
  its(:uri) { should == "/blogs/:id/articles" }
  its(:action) { should == "GET" }
  its(:headers) { should == { "content_type"=> "application/json" } }
  its(:auth) { should == false }
  its(:params) { should ==
    {"id"=>{"type"=> "integer", "description"=> "article id", "required"=> true} }
  }
  its(:description) { should == "Receive a list of all articles for given blog." }
  its(:response) { should ==
    { "data"=> [{ "id"=> 989034056, "blog_id"=>  241253187, "author"=> "John", "published_at"=> nil }], "total"=> 310 }
  }
end

describe Calamum::DocParser do

  context "with json definition file" do
    before do
      @definition = Calamum::DocParser.new(Yajl.load(File.open("spec/fixtures/sample.json")))
      @definition.load_resources
    end

    describe "definition content" do
      test_definition_content
    end

    describe "user resource" do
      test_user_resource_content
    end
  end

  context "with yaml definition file" do
    before do
      @definition = Calamum::DocParser.new(YAML.load(File.open("spec/fixtures/sample.yml")))
      @definition.load_resources
    end

    describe "definition content" do
      test_definition_content
    end

    describe "user resource" do
      test_user_resource_content
    end

  end


  context "with json separated definition files" do
    before do
      Calamum::Config[:source] = 'spec/fixtures/sample_separated.json'
      @definition = Calamum::DocParser.new(Yajl.load(File.open("spec/fixtures/sample_separated.json")))
      @definition.load_resources
    end

    describe "definition content" do
      test_definition_content
    end

    describe "user resource" do
      test_user_resource_content
    end

    describe "article resource" do
      test_article_resource_content
    end

  end

  context "with json separated definition files" do
    before do
      Calamum::Config[:source] = 'spec/fixtures/sample_separated.json'
      @definition = Calamum::DocParser.new(Yajl.load(File.open("spec/fixtures/sample_separated.json")))
      @definition.load_resources
    end

    describe "definition content" do
      test_definition_content
    end

    describe "user resource" do
      test_user_resource_content
    end

    describe "article resource" do
      test_article_resource_content
    end

  end

  context "with yml separated definition files" do
    before do
      Calamum::Config[:source] = 'spec/fixtures/sample_separated.yml'
      @definition = Calamum::DocParser.new(YAML.load(File.open("spec/fixtures/sample_separated.yml")))
      @definition.load_resources
    end

    describe "definition content" do
      test_definition_content
    end

    describe "user resource" do
      test_user_resource_content
    end

    describe "article resource" do
      test_article_resource_content
    end

  end

end
