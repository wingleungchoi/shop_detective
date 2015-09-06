class State
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :canvas

  field :name, type: String

end