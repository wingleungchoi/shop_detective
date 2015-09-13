class OrganizationKind
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embeds_many :subcategories

  field :name, type: String

end