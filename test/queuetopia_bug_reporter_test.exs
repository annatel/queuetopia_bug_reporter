defmodule QueuetopiaBugReporterTest do
  use ExUnit.Case

  import QueuetopiaBugReporter.Factory
  import Swoosh.TestAssertions

  test "handle_failed_job!" do
    Application.put_all_env(
      queuetopia_bug_reporter: [
        bugs_email_from_address: "bugs_email_from_address@queuetopia_bug_reporter.com",
        bugs_email_to_address: "bugs_email_to_address@queuetopia_bug_reporter.com",
        min_job_attempts_for_email: 2
      ]
    )

    QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 1))

    refute_email_sent()

    job = build(:job, attempts: 2)
    QueuetopiaBugReporter.handle_failed_job!(job)

    assert_email_sent(
      from: {"", "bugs_email_from_address@queuetopia_bug_reporter.com"},
      to: {"", "bugs_email_to_address@queuetopia_bug_reporter.com"},
      subject: "[#{job.scope} - Failed job (#{job.id})]"
    )

    QueuetopiaBugReporter.handle_failed_job!(build(:job, attempts: 3))
    assert_email_sent()
  end
end
