defmodule QueuetopiaBugReporter.MailerTest do
  use ExUnit.Case

  import Swoosh.TestAssertions
  alias QueuetopiaBugReporter.Mailer

  test "deliver_bugs_email/2" do
    Application.put_all_env(
      queuetopia_bug_reporter: [
        from_email_address: "from_email_address@queuetopia_bug_reporter",
        to_email_address: "to_email_address@queuetopia_bug_reporter"
      ]
    )

    Mailer.deliver_bug_email("subject", "html_body")

    assert_email_sent(
      from: {"", "from_email_address@queuetopia_bug_reporter"},
      to: {"", "to_email_address@queuetopia_bug_reporter"},
      subject: "subject",
      html_body: "html_body"
    )
  end
end
