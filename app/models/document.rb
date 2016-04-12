class Document < ActiveRecord::Base
   searchkick merge_mappings: true, mappings: {
    document: {
      properties: {
        created_at: { type: 'date' }
      }
    }
  }

   include Scopes
   
   attr_accessor :file_url
   
   belongs_to :user, counter_cache: true

   has_attached_file :file

   validates :name, presence: true
   validates :file_url, presence: true
   validates :description, presence: true
   validates :user_id, presence: true

   validates_attachment :file, presence: true, 
                               content_type: { content_type: DOCUMENT_CONTENT_TYPES },
                               size: { less_than: 3.megabytes }
  
  before_validation :set_file_from_file_url
  after_validation :set_file_url_errors

  def search_data
    {
      file_name: file_file_name,
      file_size: file_file_size,
      created_at: created_at
    }
  end

  private

  def set_file_url_errors
    self.errors[:file_url] << errors[:file].first if errors[:file].any? 
  end

  def set_file_from_file_url
    self.file = open(file_url) if !file.present? && file_url.present?
  end                                         
end