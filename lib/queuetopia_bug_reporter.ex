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
    attempts >= max_job_attempts_to_interspace_alert() or next?(attempts)
  end

  defp next?(attempts), do: rem(attempts, alert_spacing()) == 1

  @spec alert_spacing :: integer
  def alert_spacing(), do: Application.get_env(:queuetopia_bug_reporter, :alert_spacing, 5)

  @spec max_job_attempts_to_interspace_alert :: integer
  def max_job_attempts_to_interspace_alert() do
    Application.get_env(:queuetopia_bug_reporter, :max_job_attempts_to_interspace_alert, 1)
  end
end
