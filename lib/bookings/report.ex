defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(filename \\ "report.csv") do
    booking_list = build_booking_list()

    File.write(filename, booking_list)
  end

  def generate_date_report(from_date, to_date, filename \\ "report.csv") do
    booking_list = build_booking_list_date_range(from_date, to_date)

    File.write(filename, booking_list)
    {:ok, "Report generated successfully"}
  end

  defp build_booking_list_date_range(from_date, to_date) do
    BookingAgent.get_all()
    |> Map.values()
    |> Stream.filter(&compare_dates(&1, from_date, to_date))
    |> Enum.map(&booking_string/1)
  end

  defp compare_dates(%Booking{complete_date: complete_date}, from_date, to_date) do
    begin_date = NaiveDateTime.compare(complete_date, from_date)
    end_date = NaiveDateTime.compare(complete_date, to_date)

    begin_date != :lt and end_date != :gt
  end

  defp build_booking_list do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(&booking_string(&1))
  end

  defp booking_string(%Booking{
         complete_date: complete_date,
         local_origin: local_origin,
         local_destination: local_destination,
         user_id: user_id
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
