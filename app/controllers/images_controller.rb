# require 'aws-sdk'
# require 'aws-sdk-resources'
# require 'aws-sdk-core'


class ImagesController < ApplicationController
  def index
    credentials = Aws::Credentials.new('ID', 'KEY')
    s3_resource = Aws::S3::Resource::new(region: 'us-west-1', credentials: credentials)
    extension = File.extname(params[:filename])
    filename = "#{SecureRandom.uuid}.#{extension}"
    object = s3_resource.bucket('tv-capstone').object(filename)
    presigned_url = object.presigned_url(:put)
    render json: {url: presigned_url }, status: :ok
  end
end
