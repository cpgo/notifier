defmodule NotifierWeb.Json.CardController do
  use NotifierWeb, :controller

  alias Notifier.Board
  alias Notifier.Board.Card

  action_fallback NotifierWeb.FallbackController

  def index(conn, _params) do
    cards = Board.list_cards()
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    with {:ok, %Card{} = card} <- Board.create_card(card_params) do
      conn
      |> put_status(:created)
      |> render("show.json", card: card)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Board.get_card!(id)
    render(conn, "show.json", card: card)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Board.get_card!(id)

    with {:ok, %Card{} = card} <- Board.update_card(card, card_params) do
      render(conn, "show.json", card: card)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Board.get_card!(id)

    with {:ok, %Card{}} <- Board.delete_card(card) do
      send_resp(conn, :no_content, "")
    end
  end
end
