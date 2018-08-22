defmodule PhoenixSample.Services.AuthService do
  alias Comeonin.Bcrypt
  alias PhoenixSample.User
  alias PhoenixSample.Services.UserService
  alias PhoenixSample.Guardian

  def authenticate(username, password) do
    with {:ok, user} <- user_by_username(username) do
      check_password(user, password)
    else
      reply -> reply
    end
  end

  def validate_password(password, hash), do: Bcrypt.checkpw(password, hash)

  def generate_access_token(resource) do
    case Guardian.encode_and_sign(resource) do
      {:ok, access_token, _full_claims} -> {:ok, access_token}
    end
  end

  defp user_by_username(username) do
    case UserService.user_by_username(username) do
      nil -> {:error, :unauthenticated}
      user -> {:ok, user}
    end
  end

  defp check_password(%User{password: hashed_password} = user, password) do
    case validate_password(password, hashed_password) do
      true -> {:ok, user}
      _ -> {:error, :unauthenticated}
    end
  end
end
