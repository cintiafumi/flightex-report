defmodule Flightex.Bookings.Booking do
  alias Flightex.Users.User

  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]

  @enforce_keys @keys

  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_cpf) do
    {:ok,
     %__MODULE__{
       complete_date: complete_date,
       local_origin: local_origin,
       local_destination: local_destination,
       user_id: user_cpf,
       id: UUID.uuid4()
     }}
  end

  def build(_complete_date, _local_origin, _local_destination, _user_id),
    do: {:error, "Invalid parameters."}
end
