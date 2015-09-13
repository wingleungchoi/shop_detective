class Company
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  #embedded_in :subcategories
  embedded_in :tags
  embeds_many :locations

  field :name, type: String
end