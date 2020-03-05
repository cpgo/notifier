defmodule NotifierWeb.CardController do
  use NotifierWeb, :controller

  alias Notifier.Board
  alias Notifier.Board.Card

  def index(conn, _params) do
    cards = Board.list_cards()
    columns = Board.list_columns(:preload_cards)
    render(conn, "index.html", cards: cards, columns: columns)
  end

  def new(conn, _params) do
    changeset = Board.change_card(%Card{})
    columns = Board.list_columns()
    render(conn, "new.html", changeset: changeset, columns: columns)
  end

  def create(conn, %{"card" => card_params}) do
    case Board.create_card(card_params) do
      {:ok, _card} ->
        conn
        |> put_flash(:info, "Card created successfully.")
        |> redirect(to: Routes.card_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Board.get_card!(id)
    render(conn, "show.html", card: card)
  end

  def edit(conn, %{"id" => id}) do
    card = Board.get_card!(id)
    changeset = Board.change_card(card)
    render(conn, "edit.html", card: card, changeset: changeset)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Board.get_card!(id)

    case Board.update_card(card, card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card updated successfully.")
        |> redirect(to: Routes.card_path(conn, :show, card))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Board.get_card!(id)
    {:ok, _card} = Board.delete_card(card)

    conn
    |> put_flash(:info, "Card deleted successfully.")
    |> redirect(to: Routes.card_path(conn, :index))
  end
end
