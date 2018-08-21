# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixSample.Repo.insert!(%PhoenixSample.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias PhoenixSample.Repo
alias PhoenixSample.User

Repo.insert!(User.signup_changeset(%User{}, %{
  "username" => "gurimusan",
  "name" => "gurimusan",
  "password" => "gurimusan",
}))
