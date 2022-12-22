require 'csv'
class CsvClient

  def initialize(input)
    file = File.open(input)
    @data = CSV.parse(file)
  end

  def populate_database
    @data.each do |row|
        byebug
        u = User.new(email:row[0],password:row[1],first_name:row[2],last_name:row[3])
        u.skip_confirmation!
        if u.save
            puts "1 row added to database."
        else
            puts u.errors.full_messages.to_sentence
        end
    end
  end

end
