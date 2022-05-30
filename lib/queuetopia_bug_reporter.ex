defmodule QueuetopiaBugReporter do
  @moduledoc """
  Documentation for `QueuetopiaBugReporter`.
  """
  @behaviour QueuetopiaBugReporter.Behaviour

  alias QueuetopiaBugReporter.Mailer
  alias Queuetopia.Queue.Job

  @impl true
  @spec handle_failed_job!(Queuetopia.Queue.Job.t()) :: :ok
  def handle_failed_job!(%Job{} = job) do
    Mailer.deliver_bug_email(Job.email_subject(job), Job.email_html_body(job))

    :ok
  end
end
