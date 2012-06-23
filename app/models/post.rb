class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :summary
  field :published_at, type: DateTime
  
  def year
    created_at.strftime("%Y")
  end
end