defmodule QueuetopiaBugReporterTest do
  use ExUnit.Case

  import QueuetopiaBugReporter.Factory
  import Swoosh.TestAssertions

  test "handle_failed_job!/2 send emails" do
    QueuetopiaBugReporter.handle_failed_job!(build(:job))
    assert_email_sent()
  end
end
