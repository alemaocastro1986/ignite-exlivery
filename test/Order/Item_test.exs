defmodule Exlivery.Users.Item do
  use ExUnit.Case

  import Exlivery.Factory
  alias Exlivery.Orders.Item

  describe "build/4" do
    test "return a new Item, when the parameters are valid." do
      sut = Item.build("Filé grelhado com manteiga de ervas", :carne, "37.8", 2)

      expected =
        {:ok,
         %Item{
           description: "Filé grelhado com manteiga de ervas",
           category: :carne,
           quantity: 2,
           unit_price: Decimal.new("37.8")
         }}

      assert sut == expected
    end

    test "return an error, when price is invalid." do
      assert {:error, "invalid price"} =
               Item.build("Cerveja Patogônia 430ml", :bebida, "invalid-price", 12)
    end

    test "return an error, when category not in categories." do
      assert {:error, "invalid parameters"} =
               Item.build("Cerveja Patogônia 430ml", :non_category, "5.35", 12)
    end

    test "return an error, when quantity <=0" do
      assert {:error, "invalid parameters"} =
               Item.build("Cerveja Patogônia 430ml", :bebida, "5.35", 0)
    end
  end
end
