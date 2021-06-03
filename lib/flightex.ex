defmodule Flightex do
  alias Flightex.Users.{CreateOrUpdate, UserAgent}

  def start_agents do
    UserAgent.start_link(%{})
  end

  defdelegate create_or_update(params), to: CreateOrUpdate, as: :call
end
