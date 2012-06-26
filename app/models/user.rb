class User
  include Mongoid::Document
  field :twitter_uid
  field :name
  field :admin, type: Boolean
  has_many :posts
  attr_accessible :name, :twitter_uid
end