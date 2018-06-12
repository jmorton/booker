module Label
  include ActiveSupport::Concern

  def label
    "#{self.class.name} No. #{self.id}"
  end

end
