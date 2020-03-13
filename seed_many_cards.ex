Notifier.Board.list_columns() |> Enum.map(fn column -> 1..10 |> Enum.map(fn x -> Notifier.Board.create_card(%{body: "card #{x}", column_id: column.id}) end) end)
