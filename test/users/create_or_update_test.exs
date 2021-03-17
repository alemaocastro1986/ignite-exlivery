defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  setup do
    UserAgent.start_link(%{})
    :ok
  end

  describe "call/1" do
    test "return a new user" do
      user_params = %{
        name: "Andrius Cunha",
        email: "acc@exlivery.com",
        cpf: "80077808070",
        age: 34,
        address: "Rua do elixir, 2021"
      }

      assert {:ok, "user created or updated successfully."} = CreateOrUpdate.call(user_params)
    end

    test "return an error, when cpf is invalid" do
      user_params = %{
        name: "Andrius Cunha",
        email: "acc@exlivery.com",
        cpf: 80_077_808_070,
        age: 34,
        address: "Rua do elixir, 2021"
      }

      assert {:error, "invalid parameters"} = CreateOrUpdate.call(user_params)
    end

    test "return an error, when age less than 18" do
      user_params = %{
        name: "Andrius Cunha",
        email: "acc@exlivery.com",
        cpf: "80077808070",
        age: 17,
        address: "Rua do elixir, 2021"
      }

      assert {:error, "invalid parameters"} = CreateOrUpdate.call(user_params)
    end
  end
end
