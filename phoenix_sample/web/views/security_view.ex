defmodule PhoenixSample.SecurityView do
  use PhoenixSample.Web, :view

  def render("signin.json", %{user: user, token: token}) do
    %{token: token}
  end

  def render("error.json", %{error: error}) do
    %{error: error}
  end
end
