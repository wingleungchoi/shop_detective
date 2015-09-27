class Company
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :subcategory
 #embeds_many :tags
  embeds_many :locations

  field :name, type: String
end