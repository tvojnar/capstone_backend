require "test_helper"
require 'pry-rails'

describe ImagesController do
  describe 'index' do
    it 'will return a url' do
      # test that the index action returns a url 
      get images_path(filename: 'testfilename')
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.must_include 'url'
    end
  end
end
