class Conversation < ActiveRecord::Base
  searchkick merge_mappings: true, mappings: {
    conversation: {
      properties: {
        updated_at: { type: 'date' }
      }
    }
  }

  include Scopes
  
  has_and_belongs_to_many :users
  has_many :messages, dependent: :destroy
  has_many :conversations_unreads
  
  scope :with_messages, -> { where.not(messages_count: 0) }
  scope :with_unread_messages, -> { includes(:conversations_users).where('conversations_users.unread = ?', true).uniq }
  scope :order_by_unread, -> { includes(:conversations_users).order('conversations_users.unread') }
  scope :unread_for, -> (user_id) { joins(:messages).where('NOT (? = ANY(messages.readed)) AND conversations.messages_count != 0', user_id) }
  
    
  def search_data
    {
      emails: users.map(&:email),
      user_ids: users.map(&:id),
      first_names: users.map(&:first_name),
      last_names: users.map(&:last_name),
      updated_at: updated_at
    }
  end

  def unread?(user)
    self.messages.unread_for(user.id).any?
  end
end