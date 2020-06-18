defmodule Reactor.Accounts.Email do
  def banned() do
    ~w{
      notorious_spammer@example.com
      rabid_troll@example.com
      nefarious_user@example.com
    }
  end
end
