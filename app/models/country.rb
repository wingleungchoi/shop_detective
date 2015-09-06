class Country
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embeds_many :states

  field :name, type: String

end