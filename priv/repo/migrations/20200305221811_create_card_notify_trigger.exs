defmodule Notifier.Repo.Migrations.CreateCardNotifyTrigger do
  use Ecto.Migration

  def up do
    execute("""
    CREATE TRIGGER notify_card_event
    AFTER INSERT OR UPDATE OR DELETE ON cards
    FOR EACH ROW EXECUTE PROCEDURE notify_event();
    """)
  end
end
