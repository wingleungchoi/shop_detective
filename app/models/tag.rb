class Tag
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :subcategories
  embeds_many :companies

  field :name, type: String

end