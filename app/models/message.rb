class Message < ActiveRecord::Base
  searchkick merge_mappings: true, mappings: {
    message: {
      properties: {
        created_at: { type: 'date' }
      }
    }
  }

  include Scopes

  belongs_to :conversation, counter_cache: true
  belongs_to :user
  has_many :users, through: :conversation
  has_many :conversations_users, through: :conversation

  validates :body, presence: true
  validates :conversation_id, presence: true
  validates :user_id, presence: true

  scope :unread_for, -> (user_id) { where('NOT (? = ANY(readed)) AND user_id != ?', user_id, user_id) }

   def search_data
    {
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      created_at: created_at,
      body: body,
      conversation_id: conversation_id
    }
  end

  after_save :update_conversation_unread

  after_create :run_sockets

  def run_sockets
    ActionCable.server.broadcast 'messages', message: self
  end


  def add_to_readed(user_id)
    self.readed << user_id
    self.conversations_users.where(user_id: user_id).map { |cu| cu.update(unread: false) } 
    self.save
  end

  private

  def update_conversation_unread
    conversations_users.each do |conversations_user|
      if conversations_user.user_id != user_id && !readed.include?(conversations_user.id)
        conversations_user.update(unread: true) 
      end
    end
  end
end