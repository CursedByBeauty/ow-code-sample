require 'json'
require 'csv'
class DataTransformService

  # ==== This method does:
  #
  #  Iterates over the csv and transforms it into JSON documents
  #
  # ==== With params:
  #
  # @param file_path <String> - Path to the csv file to process
  #
  # ==== And returns:
  #
  # @return total_records_processed
  #
  # ==== And is used like:
  #
  # service.transform(csv_path)
  #
  def transform(file_path)

    lines = CSV.open(ARGV[0]).readlines
    keys = lines.delete lines.first

    File.open(ARGV[1], "w") do |f|
      data = lines.map do |values|
        is_int(values) ? values.to_i : values.to_s
        Hash[keys.zip(values)]
      end
      f.puts JSON.pretty_generate(data)
    Rails.logger.info("Processing file from location: [#{file_path}]")
    row_counter = 0

    CSV.open(file_path, 'r:UTF-8', headers: true) do |csv|
      csv.map(&:to_h).to_json
      csv.each do |csv_row|
        Rails.logger.debug("Processing row: #{csv_row}")

        row_counter += 1
      end
    end
    row_counter
  end

end