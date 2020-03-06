defmodule NotifierWeb.EventChannel do
  use NotifierWeb, :channel

  def join("events:*", _params, socket) do
    {:ok, socket}
  end

  def handle_in("events:*", payload, socket) do
    IO.puts("Recebi aqui mano")
    IO.inspect(payload)
    broadcast! socket, "events:*", payload
    {:noreply, socket}
  end
end
