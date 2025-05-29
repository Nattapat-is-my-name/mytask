class Task < ApplicationRecord
  validates :title, presence: true
  validates :due_time, presence: true
  validate :due_time_cannot_be_in_the_past

  def overdue?
    due_time.present? && due_time < Time.current && !completed?
  end

  # Method to check if task should have strikethrough styling
  def should_strikethrough?
    completed? || overdue?
  end

  private

  def due_time_cannot_be_in_the_past
    return if due_time.blank?

    Rails.logger.debug "Validating due_time: #{due_time} vs current time: #{Time.zone.now}"

    if due_time < Time.zone.now
      errors.add(:due_time, "can't be in the past")
    end
  end
end
