class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  field :name
  field :summary
  field :body
  field :notes
  field :publish_at, type: DateTime
  
  attr_accessible :name, :summary, :body, :notes, :tags, :publish_at
  
  def year
    created_at.strftime("%Y")
  end
end