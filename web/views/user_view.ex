defmodule PhoenixSample.UserView do
  use PhoenixSample.Web, :view

  def render("index.json", %{users: users}) do
    %{users: render_many(users, PhoenixSample.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: user |> render_one(PhoenixSample.UserView, "user.json") }
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      name: user.name,
      password: user.password}
  end

  def render("error.json", %{error: error}) do
    %{error: error}
  end
end
