defmodule Notifier.Repo do
  use Ecto.Repo,
    otp_app: :notifier,
    adapter: Ecto.Adapters.Postgres

  def listen(event_name) do
  IO.puts('dentro do listen0-----------------')
  IO.puts(event_name)
    with {:ok, pid} <- Postgrex.Notifications.start_link(__MODULE__.config()),
         {:ok, ref} <- Postgrex.Notifications.listen(pid, event_name) do
      {:ok, pid, ref}
    end
  end
end
