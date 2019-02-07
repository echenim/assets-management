defmodule Portfoliomanager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
       Plug.Cowboy.child_spec(scheme: :http, plug: Portfoliomanager.Router, options: [port: application_port()])
     
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Portfoliomanager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp application_port do
    System.get_env()
    |>Map.get("PORT", "4001")
    |> String.to_integer()
  end

end
