module ApplicationHelper
    def is_active?(section)
        if section.include?(params[:controller])
            return "active"
        end
    end
end
