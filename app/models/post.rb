class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :summary
  field :body
  field :publish_at, type: DateTime
  
  attr_accessible :name, :summary, :body, :publish_at
  
  def year
    created_at.strftime("%Y")
  end
end