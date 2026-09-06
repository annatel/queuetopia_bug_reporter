defmodule QueuetopiaBugReporter.Behaviour do
  @moduledoc """
  Documentation for `QueuetopiaBugReporter`.
  """

  @callback handle_failed_job!(Queuetopia.Jobs.Job.t()) :: :ok
end
