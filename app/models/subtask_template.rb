class SubtaskTemplate < ApplicationRecord
  belongs_to :task_template

  validate :title_and_deadline_must_be_both_present_or_absent

  private

  def title_and_deadline_must_be_both_present_or_absent
    return unless (subtask_template_title.blank? && subtask_template_days.present?) || (subtask_template_title.present? && subtask_template_days.blank?)

    errors.add(:base, 'Subtask title and deadline must be both present or absent')
  end
end
