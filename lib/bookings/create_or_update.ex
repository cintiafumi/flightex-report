defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(%{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_cpf
      }) do
    with {:ok, _user} <- UserAgent.get(user_cpf),
         {:ok, booking} <- Booking.build(complete_date, local_origin, local_destination, user_cpf) do
      BookingAgent.save(booking)
    else
      error -> error
    end
  end
end
