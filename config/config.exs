import Config

config :queuetopia_bug_reporter, QueuetopiaBugReporter.Mailer,
  adapter: if(Mix.env() == :test, do: Swoosh.Adapters.Test, else: Swoosh.Adapters.SMTP)

if Mix.env() == :test do
  config :queuetopia_bug_reporter,
    from_email_address: "from_email_address@queuetopia_bug_reporter",
    to_email_address: "to_email_address@queuetopia_bug_reporter"
end
