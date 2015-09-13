class Subcategory
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :country
  embeds_many :locations

  field :name, type: String

end