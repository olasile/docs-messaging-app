class Company < ActiveRecord::Base
  include Scopes
  
  has_many :users
  
  validates :name, presence: true
end