defmodule PhoenixSample.Services.UserService do
  alias PhoenixSample.Repo
  alias PhoenixSample.User
  alias PhoenixSample.Queries.UserByUsername

  @doc """
  Get a single user by their id
  """
  def user_by_id(id) when is_binary(id) do
    Repo.get(User, id)
  end

  @doc """
  Get an existing user by their username, or return `nil` if not registered
  """
  def user_by_username(username) when is_binary(username) do
    username
    |> UserByUsername.new()
    |> Repo.one()
  end
end
