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
  Builds a user changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :name, :password])
    |> validate_required([:username, :name, :password])
    |> validate_username_length()
    |> validate_name_length()
    |> put_change(:id, UUID.uuid4())
    |> generate_password_hash()
    |> Ecto.Changeset.unique_constraint(:username)
  end

  defp validate_username_length(changeset) do
    if get_change(changeset, :username) do
      changeset |> validate_length(:username, min: 3, max: 75)
    else
      changeset
    end
  end

  defp validate_name_length(changeset) do
    if get_change(changeset, :name) do
      changeset |> validate_length(:name, max: 30)
    else
      changeset
    end
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
