class User
  include Mongoid::Document
  field :twitter_uid
  field :name
  field :admin, type: Boolean
  field :last_login_at, type: Time
  has_many :posts
  attr_accessible :name, :twitter_uid, :last_login_at
end