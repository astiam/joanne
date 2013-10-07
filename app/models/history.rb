class History
    include Mongoid::Document
    include Mongoid::Timestamps::Created

    field :text, type: String
    field :author, type: String

    embedded_in :patient
end
