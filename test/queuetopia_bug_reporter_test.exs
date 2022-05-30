defmodule QueuetopiaBugReporterTest do
  use ExUnit.Case

  import QueuetopiaBugReporter.Factory
  import Swoosh.TestAssertions

  describe "handle_failed_job!/2" do
    test "starts alerts from min_job_attempts_for_alert" do
      Application.put_all_env(
        queuetopia_bug_reporter: [
          min_job_attempts_for_alert: 3
        ]
      )

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 1))
      refute_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 2))
      refute_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 3))
      assert_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 4))
      assert_email_sent()

      QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 5))
      assert_email_sent()
    end
  end
end
