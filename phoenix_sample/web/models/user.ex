defmodule PhoenixSample.User do
  use PhoenixSample.Web, :model

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "users" do
    field :username, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc """
  Builds a user signup changeset based on the `struct` and `params`.
  """
  def signup_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :name, :password])
    |> validate_required([:username, :name, :password])
    |> put_change(:id, UUID.uuid4())
    |> generate_password_hash()
    |> Ecto.Changeset.unique_constraint(:username)
  end

  @doc """
  Builds a user update changeset based on the `struct` and `params`.
  """
  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :name, :password])
    |> validate_required([:username, :name])
    |> generate_password_hash()
    |> Ecto.Changeset.unique_constraint(:username)
  end

  defp generate_password_hash(changeset) do
    if get_change(changeset, :password) do
      password = get_change(changeset, :password)
      hash = Comeonin.Bcrypt.hashpwsalt(password)
      changeset |> put_change(:password, hash)
    else
      changeset
    end
  end
end
