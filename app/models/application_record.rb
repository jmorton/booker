# Our (persisted) models inherit from ApplicationRecord.
#
# All persisted model changes are audited.
#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  audited
end
