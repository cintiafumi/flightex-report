defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf]
  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf) when is_bitstring(cpf) do
    %__MODULE__{
      name: name,
      email: email,
      cpf: cpf
    }
  end

  def build(_name, _email, _cpf), do: {:error, "Invalid parameters."}
end
