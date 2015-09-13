class OrganizationKind
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embeds_many :categories

  field :name, type: String

end