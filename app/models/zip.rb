class Zip
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :state
  embeds_many :locations

  field :name, type: String
  field :zip_code, type: Integer

end