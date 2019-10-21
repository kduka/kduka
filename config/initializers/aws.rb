require 'aws-sdk-v1'

AWS.config(
    :access_key_id => ENV['aws_access_key_id'],
    :secret_access_key => ENV['aws_secret_access_key']
)

S3_BUCKET =  AWS::S3.new.buckets['kduka']