defmodule NotifierWeb.ColumnController do
  use NotifierWeb, :controller

  alias Notifier.Board
  alias Notifier.Board.Column

  def index(conn, _params) do
    columns = Board.list_columns()
    render(conn, "index.html", columns: columns)
  end

  def new(conn, _params) do
    changeset = Board.change_column(%Column{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"column" => column_params}) do
    case Board.create_column(column_params) do
      {:ok, column} ->
        conn
        |> put_flash(:info, "Column created successfully.")
        |> redirect(to: Routes.column_path(conn, :show, column))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    column = Board.get_column!(id)
    render(conn, "show.html", column: column)
  end

  def edit(conn, %{"id" => id}) do
    column = Board.get_column!(id)
    changeset = Board.change_column(column)
    render(conn, "edit.html", column: column, changeset: changeset)
  end

  def update(conn, %{"id" => id, "column" => column_params}) do
    column = Board.get_column!(id)

    case Board.update_column(column, column_params) do
      {:ok, column} ->
        conn
        |> put_flash(:info, "Column updated successfully.")
        |> redirect(to: Routes.column_path(conn, :show, column))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", column: column, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    column = Board.get_column!(id)
    {:ok, _column} = Board.delete_column(column)

    conn
    |> put_flash(:info, "Column deleted successfully.")
    |> redirect(to: Routes.column_path(conn, :index))
  end
end
