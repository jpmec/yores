defmodule Yores.Repo.Migrations.CreateScene do
  use Ecto.Migration

  def change do
    create table(:scenes) do
      add :name, :string

      timestamps
    end

  end
end
