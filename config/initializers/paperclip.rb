Paperclip.interpolates(:s3_us_west_url) { |attachment, style|
  "#{attachment.s3_protocol}://#{attachment.s3_host_name}/#{attachment.path(style).gsub(%r{^/}, '')}"
}

Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_region] = ENV['AWS_REGION']
Paperclip::Attachment.default_options[:bucket] = ENV['FOG_DIRECTORY']
Paperclip::Attachment.default_options[:s3_credentials][:bucket] = ENV['FOG_DIRECTORY']
Paperclip::Attachment.default_options[:s3_credentials][:access_key_id] = ENV['AWS_ACCESS_KEY_ID']
Paperclip::Attachment.default_options[:s3_credentials][:secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']

# #https://steeltoadapps.s3.amazonaws.com/uploads/1459977764674-23ds09454ge-d86d8256faf13b1e9dcd79304c289117/contacts.csv
Paperclip::Attachment.default_options[:s3_host_name] = 'steeltoadapps.s3.amazonaws.com'
Paperclip::Attachment.default_options[:url] = ':s3_us_west_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'

# Rails.application.configure do 
#   config.paperclip_defaults = {
#     :storage => :s3,
#     :s3_region => ENV['AWS_REGION'],
#     :s3_credentials => {
#       :bucket => ENV['FOG_DIRECTORY'],
#       :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
#       :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
#       }
#     }
# end