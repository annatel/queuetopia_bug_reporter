defmodule QueuetopiaBugReporter.MailerTest do
  use ExUnit.Case

  import Swoosh.TestAssertions
  alias QueuetopiaBugReporter.Mailer

  test "deliver_bugs_email/2" do
    Application.put_all_env(
      queuetopia_bug_reporter: [
        bugs_email_from_address: "bugs_email_from_address@queuetopia_bug_reporter.com",
        bugs_email_to_address: "bugs_email_to_address@queuetopia_bug_reporter.com"
      ]
    )

    Mailer.deliver_bug_email("subject", "html_body")

    assert_email_sent(
      from: {"", "bugs_email_from_address@queuetopia_bug_reporter.com"},
      to: {"", "bugs_email_to_address@queuetopia_bug_reporter.com"},
      subject: "subject",
      html_body: "html_body"
    )
  end
end
