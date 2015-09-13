class State
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :country
  embeds_many :zips
  embeds_many :locations

  field :name, type: String
  field :code, type: String
end