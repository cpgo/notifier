defmodule Notifier.Board.Listener do
  use GenServer
  require Logger

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(opts \\ []),
    do: GenServer.start_link(__MODULE__, opts)

  def init(opts) do
    with {:ok, _pid, _ref} <- Notifier.Repo.listen("events") do
      {:ok, opts}
    else
      error -> {:stop, error}
    end
  end



  def handle_info({:notification, _pid, _ref, "events", payload}, _state) do
    with {:ok, data} <- Jason.decode(payload, keys: :atoms) do
      data
      |> inspect()
      |> Logger.info()

      IO.inspect(data)
      {:noreply, :event_handled}
    else
      error -> {:stop, error, []}
    end
  end
end
