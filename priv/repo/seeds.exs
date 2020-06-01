# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Reactor.Repo.insert!(%Reactor.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Reactor.Accounts

Accounts.create_user(%{
  name: "Luke Skywalker",
  email: "awesome@gmail.com",
  is_verified: true,
  website: "https://google.com",
})

Accounts.create_user(%{
  name: "John Doe",
  email: "test1@test.com",
})
