# QueuetopiaBugReporter

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `queuetopia_bug_reporter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:queuetopia_bug_reporter, "~> 0.1.0"}
  ]
end
```

To config, add the code below in the config/runtime.exs file.
```elixir
config :queuetopia_bug_reporter,
    bugs_email_from_address: System.fetch_env!("BUGS_EMAIL_FROM_ADDRESS"),
    bugs_email_to_address: System.fetch_env!("BUGS_EMAIL_TO_ADDRESS"),
    min_job_attempts_for_email:
      System.get_env("MIN_JOB_ATTEMPTS_FOR_EMAIL", "1") |> String.to_integer()

config :queuetopia_bug_reporter, QueuetopiaBugReporter.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: System.get_env("SMTP_RELAY"),
  port: System.get_env("SMTP_PORT", "1025") |> String.to_integer(),
  retries: System.get_env("SMTP_RETRIES", "5") |> String.to_integer()
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/queuetopia_bug_reporter>.

