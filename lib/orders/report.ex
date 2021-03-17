defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.{Item, Order}

  def create(file_name \\ "report.csv") do
    order_list = build_order_list()

    "reports/#{file_name}"
    |> File.write(order_list)

    {:ok, :report_created}
  end

  defp build_order_list do
    OrderAgent.get_all()
    |> Map.values()
    |> Enum.map(&order_string/1)
  end

  defp order_string(%Order{user_cpf: user_cpf, items: items, total_price: total_price}) do
    items_string = Enum.map(items, &item_string/1)
    "#{user_cpf},#{items_string}#{total_price}\n"
  end

  defp item_string(%Item{
         description: _description,
         category: category,
         unit_price: unit_price,
         quantity: quantity
       }) do
    "#{category},#{unit_price},#{quantity},"
  end
end
