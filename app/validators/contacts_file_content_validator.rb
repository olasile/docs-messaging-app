require 'smarter_csv'

class ContactsFileContentValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    data = SmarterCSV.process(open(record.file_url), remove_empty_values: false)
    record.rows = data
    record.errors[attribute] << "Please check file content, need more info" if data.any? { |v| v.values.any? { |a| a.nil? } }
  end
end