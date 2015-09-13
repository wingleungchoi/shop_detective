class Category
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :organization_kind
  embeds_many :subcategories

  field :name, type: String

end