defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report
  alias Exlivery.Users.Agent, as: UserAgent

  setup do
    Exlivery.start_agents()

    build_list(4, :order)
    |> Enum.each(&OrderAgent.save/1)

    :ok
  end

  describe "create/1" do
    test "create the report file" do
      assert {:ok, :report_created} = Report.create("report_test.csv")

      expected =
        {:ok,
         "00822245788,bebida,200.05,1,bebida,8.00,2,216.05\n00822245788,bebida,200.05,1,bebida,8.00,2,216.05\n" <>
           "00822245788,bebida,200.05,1,bebida,8.00,2,216.05\n00822245788,bebida,200.05,1,bebida,8.00,2,216.05\n"}

      assert File.read("reports/report_test.csv") == expected
    end
  end
end
