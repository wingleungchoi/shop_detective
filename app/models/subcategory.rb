class Subcategory
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :organization_kind
  embeds_many :companies

  field :name, type: String

end