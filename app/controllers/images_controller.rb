# require 'aws-sdk'
# require 'aws-sdk-resources'
# require 'aws-sdk-core'


class ImagesController < ApplicationController
def index
  # NOTE: to get passed accessDenied error from s3 I had to changemy resource from "arn:aws:s3:::tv-capstone" to "arn:aws:s3:::tv-capstone/*"
  # NOTE: might be able to use object.public_url  to get the url i want, but it doesn't work yet. I also might be able to generate them by adding 'https://s3-us-west-2.amazonaws.com/tv-capstone/' to filename
    ## THIS WORKSS!!!! (adding the parts together)
    # so I should pass the filename generated in #index back to the client and add the strings together in the client and then in the success for the PUT to s3 make a call to the API to add the image url to my db

    # see this resource https://stuff-things.net/2016/03/16/uploading-from-rails-to-aws-s3-with-presigned-urls/
    # have to have the dot-env gems to be able to access ENV variables :)
    id = ENV['AWS_ACCESS_KEY_ID']
    key = ENV['AWS_SECRET_ACCESS_KEY']
    # credentials = Aws::Credentials.new('ID', 'KEY')
    # credentials = Aws::Credentials.new('AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY')
    # set the credentials using the ENV variables
    credentials = Aws::Credentials.new(id, key)

    s3_resource = Aws::S3::Resource.new(region: 'us-west-2', credentials: credentials, )
  #   s3_resource = Aws::S3::Resource::new(region: 'us-west-2',   access_key_id: id,
  # secret_access_key: key)
    # s3_resource = Aws::S3::Resource::new(region: 'us-west-2')
    # binding.pry
    # pull out the file name from params
    # extension = File.extname(params[:filename])
    # pull out the file name from params
    extension = params[:filename]
    #add a random number to it to make sure that the filename sent to S3 is unique
    filename = "#{SecureRandom.uuid}.#{extension}"
    object = s3_resource.bucket('tv-capstone').object(filename)
    # get the url to pass to the client
    # presigned_url = object.presigned_url(:put)
    presigned_url = object.presigned_url(:put, content_type: params[:content_type], expires_in: 10.minutes.to_i, acl: 'public-read')
    render json: {url: presigned_url, fileName: filename }, status: :ok
    # binding.pry
  end
end
