defmodule PhoenixSample.Queries.UserByUsername do
  import Ecto.Query

  alias PhoenixSample.User

  def new(username) do
    from u in User,
    where: u.username == ^username
  end
end
