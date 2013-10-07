class Patient
  include Mongoid::Document
  field :firstname, type: String
  field :lastname, type: String
  field :telephone, type: String
  field :telephone_aux, type: String
  field :cellphone, type: String
  field :address, type: String
  field :id_card, type: String
end
