defmodule QueuetopiaBugReporter.Mailer do
  use Swoosh.Mailer, otp_app: :queuetopia_bug_reporter
  import Swoosh.Email
  require Protocol

  @spec deliver_bug_email(binary, binary) :: nil | {:error, any} | {:ok, any}
  def deliver_bug_email(subject, html_body) when is_binary(subject) and is_binary(html_body) do
    new()
    |> from(bugs_email_from_address())
    |> to(bugs_email_to_address())
    |> subject(subject)
    |> html_body(html_body)
    |> deliver()
  end

  defp bugs_email_from_address(),
    do: Application.get_env(:queuetopia_bug_reporter, :bugs_email_from_address)

  defp bugs_email_to_address(),
    do: Application.get_env(:queuetopia_bug_reporter, :bugs_email_to_address)
end
