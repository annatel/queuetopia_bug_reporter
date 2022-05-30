defmodule QueuetopiaBugReporter.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :queuetopia_bug_reporter,
      version: version(),
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :runtime_tools, :swoosh, :gen_smtp]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:hackney, "~> 1.9"},
      {:queuetopia, "~> 2.3"},
      {:swoosh, "~> 1.5"},
      {:gen_smtp, "~> 1.0"}
    ]
  end

  defp aliases do
    [
      "app.version": &display_app_version/1
    ]
  end

  defp version(), do: @version
  defp display_app_version(_), do: Mix.shell().info(version())
end
