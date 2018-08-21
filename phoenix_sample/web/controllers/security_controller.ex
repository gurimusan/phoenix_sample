defmodule PhoenixSample.SecurityController do
  use PhoenixSample.Web, :controller

  alias PhoenixSample.User
  alias PhoenixSample.Services.AuthService

  def signin(conn, %{"password" => password, "username" => username}) do
    with {:ok, %User{} = user} <- AuthService.authenticate(username, password),
         {:ok, token} <- AuthService.generate_access_token(user) do
       conn
        |> put_status(:created)
        |> render(PhoenixSample.SecurityView, "signin.json", user: user, token: token)
    else
      {:error, :unauthenticated} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixSample.SecurityView, "error.json", error: %{"username or password" => ["is invalid"]})
    end
  end
end
