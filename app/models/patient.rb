class Patient
    include Mongoid::Document
    include Mongoid::Timestamps::Created
    include Kaminari::MongoidExtension::Criteria
    include Kaminari::MongoidExtension::Document
    include Autocomplete

    field :firstname, type: String
    field :lastname, type: String
    field :telephone, type: String
    field :telephone_aux, type: String
    field :cellphone, type: String
    field :address, type: String
    field :id_card, type: String
    field :first_contact, type: String
    field :helped_by, type: String

    embeds_many :histories
end
