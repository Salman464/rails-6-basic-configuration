require 'csv'
class CsvClient

  def initialize(input)
    file = File.open(input)
    @data = CSV.parse(file)
  end

  def execute
    CreatUsersFromCsvJob.perform_async(@data)
  end

end
