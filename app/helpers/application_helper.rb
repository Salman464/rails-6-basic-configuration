module ApplicationHelper

    def flash_class(level)
        case level
            when :notice then "alert alert-info"
            when :success then "alert alert-success"
            when :error then "alert alert-error"
            when :alert then "alert alert-error"
        end
    end
    def format_date(date)
        date.strftime('%d %b, %Y')
    end

    def get_age(dob)
        ((Date.today - dob)/365).to_i
    end
end
