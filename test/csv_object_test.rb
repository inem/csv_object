require 'test_helper'

class CsvObjectTest < Minitest::Test
  def test_subset
    file_path = 'test/fixtures/people.csv'
    csv = CsvObject.new(file_path)

    new_csv = csv.subset(['1011', '1012', '1013'], 'Id')
    assert { new_csv.size == 3 }

    new_csv = csv.subset(['1011', '1013'], 'Id')
    assert { new_csv.size == 2 }
  end

  def test_sorting
    file_path = 'test/fixtures/people.csv'
    csv = CsvObject.new(file_path)

    data = csv.sort { |a, b| a[2].to_i <=> b[2].to_i }.map{|a| [a["Name"], a["Age"]]}
    expected = [["Mike", "13"], ["Zoran", "22"], ["Annette", "27"]]

    assert { data == expected }
  end
end