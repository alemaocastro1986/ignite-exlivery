defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "John Doe",
      email: "john.doe@exlivery.com",
      cpf: "00822245788",
      address: "Rua Elixir, 2021",
      age: 34
    }
  end

  def item_factory do
    %Item{
      category: :bebida,
      description: "Ceverja Elixir 600ml com lúpulo purple",
      quantity: 2,
      unit_price: Decimal.new("8.00")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua Elixir, 2021",
      items: [
        %Item{
          category: :bebida,
          description: "licor Elixir",
          quantity: 1,
          unit_price: Decimal.new("200.05")
        },
        build(:item)
      ],
      total_price: Decimal.new("216.05"),
      user_cpf: "00822245788"
    }
  end
end
