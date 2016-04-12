class User < ActiveRecord::Base
  searchkick merge_mappings: true, mappings: {
    user: {
      properties: {
        created_at: { type: 'date' }
      }
    }
  }

  geocoded_by :zipcode

  include Scopes

  attr_accessor :company_name

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         validate_on_invite: true

  belongs_to :company, counter_cache: true
  has_many :documents
  has_many :contacts_files
  has_many :conversations_users
  has_and_belongs_to_many :conversations
  has_many :messages
  has_many :users, through: :conversations, source: :users
  has_many :all_messages, through: :conversations, source: :messages
  
  validates :zipcode, presence: true
  validates :company_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  #validates :phone, phony_plausible: true
  
  has_attached_file :avatar, styles: { thumb: '50x50#' }
  validates_attachment :avatar, content_type: { content_type: %w(image/jpg image/jpeg image/png image/gif) },
                                size: { less_than: 3.megabytes }
  

  before_validation :set_company
  before_save :set_avatar
  after_validation :geocode 

  def contacts
    users.where.not(id: id).uniq
  end

  def unread_conversations
    conversations.with_unread_messages.unread_for(id)
  end

  def search_data
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      created_at: created_at,
      category: category,
      company_name: company.try(:name),
      zipcode: zipcode,
      location: [latitude, longitude]
    }
  end

  def self.invite_or_find(user_params)
    result = User.new(user_params)
    
    if user_params[:email].present?
      result = User.where(email: user_params[:email]).first
      result = User.invite!(user_params) unless result.present?
    end

    result
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  private

  def set_avatar
    self.avatar = Dragonfly.app.generate(:initial_avatar, full_name).file unless self.avatar.present?
  end

  def set_company
    self.company ||= Company.where(name: 'fake').first_or_create 
  end
end
