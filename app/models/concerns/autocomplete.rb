module Autocomplete
    extend ActiveSupport::Concern

    included do
        field :autocomplete
        before_save :generate_autocomplete
    end

    def generate_autocomplete
        s = self.firstname
        s = s.truncate(45, omission: "", separator: " ") if s.length > 45
        write_attribute(:autocomplete, Autocomplete.normalize(s))
    end

    def self.normalize(s)
        s = s.upcase
        s = s.gsub("'", "")
        s = s.gsub("&", " AND ")
        s = s.gsub(/[^A-Z0-9 ]/, " ")
        s = s.gsub(/ THE /, "")
        s = s.squish
        s = " #{s}"
        s
    end
end
