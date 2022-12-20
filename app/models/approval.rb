class Approval < ApplicationRecord
    belongs_to :user

    enum status: {
        started: 0,
        pending: 1,
        completed: 2,
        approved: 3,
        rejected: 4
    }
end
