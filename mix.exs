defmodule Birdiy.MixProject do
  use Mix.Project

  def project do
    [
      app: :birdiy,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Birdiy.Application, []},
      extra_applications: [:logger, :runtime_tools, :guardian, :edeliver]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # General
      {:elixir_uuid, "~> 1.2"},
      {:poison, "~> 3.1"},
      {:jason, "~> 1.0"},
      {:deep_merge, "~> 1.0"},
      {:httpoison, "~> 1.4"},

      # Phoenix & Database
      {:phoenix, "~> 1.4.3"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:plug_cowboy, "~> 2.0"},
      {:ecto_soft_delete, "~> 1.0"},

      # Authentication
      {:guardian, "~> 1.0"},

      # Absinthe
      {:absinthe, "~> 1.4.16"},
      {:absinthe_plug, "~> 1.4.6"},
      {:absinthe_phoenix, "~> 1.4.3"},
      {:absinthe_relay, "~> 1.4.6"},
      {:dataloader, "~> 1.0.0"},

      # S3
      {:arc, "~> 0.11.0"},
      {:arc_ecto, "~> 0.11.1"},
      {:ex_aws, "~> 2.1"},
      {:ex_aws_s3, "~> 2.0"},
      {:hackney, "~> 1.9"},
      {:sweet_xml, "~> 0.6"},

      # Deployment
      {:edeliver, ">= 1.6.0"},
      {:distillery, "~> 2.0", warn_missing: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
