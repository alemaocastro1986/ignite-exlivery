defmodule Exlivery.Orders.Item do
  @categories [:pizza, :hamburger, :carne, :prato_feito, :japose, :sobremesa, :bebida]

  @keys [:description, :category, :unit_price, :quantity]
  @enforce_keys @keys
  defstruct @keys

  def build(description, category, unit_price, quantity)
      when quantity > 0 and category in @categories do
    unit_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  def build(_description, _category, _unit_price, _quantity) do
    {:error, "invalid parameters"}
  end

  defp build_item({:ok, unit_price}, description, category, quantity) do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unit_price: unit_price,
       quantity: quantity
     }}
  end

  defp build_item(:error, _description, _category, _quantity) do
    {:error, "invalid price"}
  end
end