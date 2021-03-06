defmodule Birdiy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Birdiy.Repo,
      # Start the endpoint when the application starts
      BirdiyWeb.Endpoint,
      # Starts a worker by calling: Birdiy.Worker.start_link(arg)
      # {Birdiy.Worker, arg},
      {
        ConCache,
        [
          name: :project_view,
          ttl_check_interval: :timer.seconds(10),
          global_ttl: :timer.minutes(10)
        ]
      },
      Birdiy.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Birdiy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BirdiyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
