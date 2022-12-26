# frozen_string_literal: true

class Approval < ApplicationRecord
  belongs_to :user

  enum status: {
    started: 0,
    pending: 1,
    submitted: 2,
    approved: 3,
    rejected: 4
  }

  ransacker :id_to_s do
    Arel.sql("regexp_replace(to_char(\"#{table_name}\".\"id\", '9999999'), ' ', '', 'g')")
  end
end
