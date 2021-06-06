defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBookings
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_or_update_booking(params), to: CreateOrUpdateBookings, as: :call
  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate generate_report(from_date, to_date, filename), to: Report, as: :generate_date_report
end
