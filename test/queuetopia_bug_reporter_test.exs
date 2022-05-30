defmodule QueuetopiaBugReporterTest do
  use ExUnit.Case

  import QueuetopiaBugReporter.Factory
  import Swoosh.TestAssertions

  describe "handle_failed_job!/2" do
    test "interspace alerts with job attempts up to max_job_attempts_to_interspace_alert" do
      Application.put_all_env(
        queuetopia_bug_reporter: [
          min_job_attempts_for_alert: 1,
          alert_spacing: 5,
          max_job_attempts_to_interspace_alert: 6
        ]
      )

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 1))
      assert_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 2))
      refute_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 3))
      refute_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 4))
      refute_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 5))
      refute_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 6))
      assert_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 7))
      assert_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 8))
      assert_email_sent()
    end
  end
end
