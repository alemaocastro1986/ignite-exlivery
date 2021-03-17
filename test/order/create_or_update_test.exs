defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  setup do
    Exlivery.start_agents()

    build(:user, cpf: "22847973001")
    |> UserAgent.save()

    :ok
  end

  describe "call/1" do
    test "returns a order, when all parameters are valid" do
      assert {:ok, _uuid} =
               CreateOrUpdate.call(%{
                 user_cpf: "22847973001",
                 items: [
                   %{
                     description: "Tequila Jose Cuervo 1L",
                     category: :bebida,
                     unit_price: "80.0",
                     quantity: 1
                   },
                   %{
                     description: "Pizza la mexicana marguerita",
                     category: :pizza,
                     unit_price: "40.0",
                     quantity: 1
                   },
                   %{
                     description: "Pizza la mexicana carnitas",
                     category: :pizza,
                     unit_price: "45.0",
                     quantity: 1
                   }
                 ]
               })
    end

    test "return an error, when user not found" do
      assert {:error, :user_not_found} =
               CreateOrUpdate.call(%{
                 user_cpf: "99999999999",
                 items: [
                   %{
                     description: "Tequila Jose Cuervo 1L",
                     category: :bebida,
                     unit_price: "80.0",
                     quantity: 1
                   }
                 ]
               })
    end

    test "return an error, when one or more items invalid" do
      assert {:error, :invalid_items} =
               CreateOrUpdate.call(%{
                 user_cpf: "22847973001",
                 items: [
                   %{
                     description: "Tequila Jose Cuervo 1L",
                     category: :bebida,
                     unit_price: "80.0",
                     quantity: 1
                   },
                   %{
                     description: "Pizza la bodeguita Big",
                     category: :massas,
                     unit_price: "60.0",
                     quantity: 1
                   }
                 ]
               })
    end

    test "return an error, when empty list items." do
      assert {:error, "invalid parameters"} =
               CreateOrUpdate.call(%{
                 user_cpf: "22847973001",
                 items: []
               })
    end
  end
end
