defmodule QueuetopiaBugReporter.Factory do
  def build(:job, attrs \\ []) do
    Queuetopia.Factories.build(:job, attrs)
  end
end
