# require 'aws-sdk'
# require 'aws-sdk-resources'
# require 'aws-sdk-core'


class ImagesController < ApplicationController
def index
    # see this resource https://stuff-things.net/2016/03/16/uploading-from-rails-to-aws-s3-with-presigned-urls/
    credentials = Aws::Credentials.new('ID', 'KEY')
    s3_resource = Aws::S3::Resource::new(region: 'us-west-2', credentials: credentials, )
    # pull out the file name from params
    # extension = File.extname(params[:filename])
    extension = params[:filename]
    #add a random number to it to make sure that the filename sent to S3 is unique
    filename = "#{SecureRandom.uuid}.#{extension}"
    object = s3_resource.bucket('tv-capstone').object(filename)
    # get the url to pass to the client
    # presigned_url = object.presigned_url(:put, content_type: params[:content_type] )
    presigned_url = object.presigned_url(:put, expires_in: 5.minutes.to_i)
    render json: {url: presigned_url }, status: :ok
    # binding.pry
  end
end
