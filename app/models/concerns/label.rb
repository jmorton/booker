# frozen_string_literal: true

# Add behaviors for producing a display value for a model suitable for humans.
#
# REVIEW: Providing an implementation for `to_s` seems like it will make things
#   harder for developers, unless I'm missing something, this feels better.
#
module Label
  include ActiveSupport::Concern

  def label
    "#{self.class.name} No. #{id}"
  end
end
