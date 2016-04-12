require 'smarter_csv'

class ContactsFile < ActiveRecord::Base
   include Scopes
   
   attr_accessor :file_url, :rows

   belongs_to :user, counter_cache: true

   has_attached_file :file, s3_protocol: :https

   validates :file, contacts_file_content: true, if: :file_url
   validates :user_id, presence: true
   validates_attachment :file, presence: true, 
                               content_type: { content_type:  'text/plain' },
                               size: { less_than: 3.megabytes }
                                         
  before_validation :set_file_from_file_url
  
  def create_contacts    
    if rows.any?
      conversation = Conversation.new
    
      rows.each do |row|
        conversation.users << User.invite_or_find(row)
      end

      if conversation.users.any?
        conversation.users << user
        conversation.save
      end
    end

    conversation.users
  end

  private
  
  def set_file_from_file_url
    self.file = open(file_url) if !file.present? && file_url.present?
  end
end