# require 'aws-sdk'
# require 'aws-sdk-resources'
# require 'aws-sdk-core'


class ImagesController < ApplicationController
def index
    # see this resource https://stuff-things.net/2016/03/16/uploading-from-rails-to-aws-s3-with-presigned-urls/
    # id = ENV['AWS_ACCESS_KEY_ID']
    # key = ENV['AWS_SECRET_ACCESS_KEY']
    # credentials = Aws::Credentials.new('ID', 'KEY')
    credentials = Aws::Credentials.new('AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY')
    # binding.pry
    s3_resource = Aws::S3::Resource::new(region: 'us-west-2', credentials: credentials, )
    # s3_resource = Aws::S3::Resource::new(region: 'us-west-2', credentials: Aws::Credentials.new('access-key-id', 'secret-access-key'))
    # s3_resource = Aws::S3::Resource::new(region: 'us-west-2')
    # pull out the file name from params
    # extension = File.extname(params[:filename])
    extension = params[:filename]
    #add a random number to it to make sure that the filename sent to S3 is unique
    filename = "#{SecureRandom.uuid}.#{extension}"
    object = s3_resource.bucket('tv-capstone').object(filename)
    # get the url to pass to the client
    # presigned_url = object.presigned_url(:put)
    presigned_url = object.presigned_url(:put, content_type: params[:content_type], expires_in: 5.minutes.to_i, acl: 'public-read')
    render json: {url: presigned_url }, status: :ok
    # binding.pry
  end
end
