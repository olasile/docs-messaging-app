namespace :searchkick do
  task reindex_all: :environment do
    [Message, Conversation, User, Document].map { |m| m.reindex }
  end
end