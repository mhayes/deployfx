class Post
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes #for DateTime
  include Mongoid::Timestamps
  include Mongoid::Taggable
  include Mongoid::Slug
  field :name
  field :summary
  field :body
  field :notes
  field :draft, type: Boolean
  field :publish_at, type: Time, default: -> {Time.now}
  belongs_to :user
  attr_accessible :name, :summary, :body, :notes, :tags, :publish_at, :draft
  
  slug :name
  scope :recent, order_by(:publish_at, :desc)
  scope :published, lambda {where(:publish_at.lt => Time.now.utc, :draft.ne => true)}
  
  def year
    publish_at.strftime("%Y")
  end
end