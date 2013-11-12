class Patient
    include Mongoid::Document
    include Mongoid::Timestamps::Created
    include Kaminari::MongoidExtension::Criteria
    include Kaminari::MongoidExtension::Document
    include Autocomplete

    field :fullname, type: String
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

    self.fields.keys.each do |field|
        scope "search_by_#{field.to_s}".to_sym, ->(query) { where(field.to_s.to_sym => /.*#{query}.*/i) }
    end

    def customize_value
        "#{self.firstname} #{self.lastname}"
    end
end
