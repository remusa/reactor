defmodule ReactorWeb.Token do
  @namespace "user salt"

  def sign(data) do
    Phoenix.Token.sign(ReactorWeb.Endpoint, @namespace, data)
  end

  def verify(token) do
    Phoenix.Token.verify(
      ReactorWeb.Endpoint,
      @namespace,
      token,
      max_age: 365 * 24 * 3600
    )
  end
end
