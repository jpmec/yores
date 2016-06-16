defmodule Yores.Repo.Migrations.CreateNarrator do
  use Ecto.Migration

  def change do
    create table(:narrators) do
      add :name, :string

      timestamps
    end

  end
end
