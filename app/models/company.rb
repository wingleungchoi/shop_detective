class Company
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :subcategories
  embedded_in :tags
  embeds_many :locations

  field :name, type: String
  field :tag_names, type: Array #Undesired Practise but I don't wanna pay Mongodb yet
  field :telephone, type: String
end