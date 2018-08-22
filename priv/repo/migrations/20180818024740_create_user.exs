defmodule PhoenixSample.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :username, :string, size: 75
      add :name, :string, size: 30
      add :password, :string, size: 128

      timestamps()
    end
    create unique_index(:users, [:username])
  end
end
