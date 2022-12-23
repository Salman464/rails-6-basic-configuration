require 'csv'
class CsvClient

  def initialize(input)
    file = File.open(input)
    @data = CSV.parse(file)
  end

  def populate_database
    @data.each do |row|
      CreatUsersFromCsvJob.perform_async(row)
    end
  end

end
