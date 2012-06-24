class Post
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps
  include Mongoid::Taggable
  field :name
  field :summary
  field :body
  field :notes
  field :publish_at, type: Time, default: -> {Time.now}
  belongs_to :user
  attr_accessible :name, :summary, :body, :notes, :tags, :publish_at
  
  scope :recent, order_by(:published_at, :desc)
  scope :published, lambda {where(:publish_at.lt => Time.now.utc)}
  
  def year
    publish_at.strftime("%Y")
  end
end