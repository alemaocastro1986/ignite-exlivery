defmodule Exlivery.Orders.Order do
  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys
  defstruct @keys

  def build(%User{cpf: user_cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: user_cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total_price(items)
     }}
  end

  def build(_user, _items) do
    {:error, "invalid parameters"}
  end

  defp calculate_total_price(items) do
    items
    |> Enum.reduce(Decimal.new("0.00"), &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{quantity: qtd, unit_price: price}, acc) do
    Decimal.mult(qtd, price)
    |> Decimal.add(acc)
  end
end
