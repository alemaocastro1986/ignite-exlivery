defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case
  import Exlivery.Factory

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  describe "build/2" do
    test "return new order, when the parameters are valid." do
      %User{address: address, cpf: cpf} = user = build(:user)

      items = [
        build(:item, %{description: "licor Elixir", quantity: 1, unit_price: "200.05"}),
        build(:item)
      ]

      order = build(:order)

      assert {:ok, order} = Order.build(user, items)
    end

    test "return an error, when there are no items in the order." do
      user = build(:user)

      assert {:error, "invalid parameters"} = Order.build(user, [])
    end

    test "return an error, when user is invalid." do
      items = build_list(2, :item)

      assert {:error, "invalid parameters"} = Order.build(%{}, items)
    end
  end
end
