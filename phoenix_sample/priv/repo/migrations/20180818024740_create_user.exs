defmodule PhoenixSample.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :username, :string
      add :name, :string
      add :password, :string

      timestamps()
    end
    create unique_index(:users, [:username])
  end
end
