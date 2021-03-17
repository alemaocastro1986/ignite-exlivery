defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case
  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent

  setup do
    OrderAgent.start_link(%{})

    {:ok, uuid} =
      build(:order)
      |> OrderAgent.save()

    %{order_id: uuid}
  end

  describe "save/1" do
    test "returns ok, when order is persisted" do
      assert {:ok, _uuid} =
               build(:order)
               |> OrderAgent.save()
    end
  end

  describe "get/1" do
    test "returns order, when informed a valid uuid", %{order_id: order_id} do
      assert {:ok, _uuid} = OrderAgent.get(order_id)
    end

    test "returns an eror, when informed invalid uuid" do
      assert {:error, :order_not_found} = OrderAgent.get("b8ddeeb1-c495-44bc-abf7-377d754767f6")
    end
  end

  describe "get_all/0" do
    test "returns all orders" do
      build(:order)
      |> OrderAgent.save()

      assert length(Map.values(OrderAgent.get_all())) == 2
    end
  end
end
