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
    if needs_alert?(job) do
      Mailer.deliver_bug_email(Job.email_subject(job), Job.email_html_body(job))
    end

    :ok
  end

  defp needs_alert?(%Job{attempts: attempts}) do
    attempts >= min_job_attempts_for_alert()
  end

  defp min_job_attempts_for_alert(),
    do: Application.get_env(:queuetopia_bug_reporter, :min_job_attempts_for_alert)
end
