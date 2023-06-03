class Subtask < ApplicationRecord
  belongs_to :task

  validate :title_and_deadline_must_be_both_present_or_absent

  private

  def title_and_deadline_must_be_both_present_or_absent
    if (subtask_title.blank? && subtask_deadline.present?) || (subtask_title.present? && subtask_deadline.blank?)
      errors.add(:base, "Subtask title and deadline must be both present or absent")
    end
  end
end
