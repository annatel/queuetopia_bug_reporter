import Config

config :queuetopia_bug_reporter, QueuetopiaBugReporter.Mailer,
  adapter: if(Mix.env() == :test, do: Swoosh.Adapters.Test, else: Swoosh.Adapters.SMTP)
