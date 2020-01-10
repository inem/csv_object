require 'csv'
require "csv_object/version"

class CsvObject
  # class Error < StandardError; end

  def self.generate(array_of_hashes)
    CSV.generate do |csv|
      csv << array_of_hashes.first.keys
      array_of_hashes.each do |hash|
        csv << hash.values
      end
    end
  end

  def self.wrap(content)
    case content
    when CSV::Table
      content
    when String
      if content =~ /\n/
        content
      elsif FileTest.exist?(content)
        wrap(Pathname.new(content))
      else
        content
      end
    when Pathname
      IO.read(content)
    when Array # array of hashes
      CsvObject.generate(content)
    when Paperclip::Attachment
      Paperclip.io_adapters.for(content).read  # https://stackoverflow.com/questions/6555468
    when CsvObject
      content.to_csv
    else
      raise ArgumentError, "unexpected object class '#{content.class}'"
    end
  end

  def initialize(content)
    @csv = CSV.parse(CsvObject.wrap(content), headers: true)
  end

  def to_a
    @csv
  end

  def sort(&block)
    to_hash @csv.sort(&block)
  end

  def to_h
    to_hash @csv
  end

  def headers
    @headers ||= @csv.headers
  end

  def to_csv
    @csv.to_csv
  end

  def to_s
    to_csv
  end

  def subset(ids, id_column_name)
    id_column_index = headers.index(id_column_name)

    tmp = CSV.generate(headers: true) do |row|
      row << headers

      to_a.each do |hash|
        id_value = hash[id_column_index]
        row << hash if ids.include?(id_value)
      end
    end

    CsvObject.new(tmp)
  end

  def to_file(path)
    CSV.open(path, 'wb') do |file|
      file << headers
      to_h.each do |hash|
        file << hash.values_at(*headers)
      end
    end
  end

  def size
    to_h.size
  end

  private

  def to_hash(collection)
    hash = collection.map(&:to_hash)
    defined?(ActiveSupport) ? hash.map(&:with_indifferent_access) : hash
  end
end