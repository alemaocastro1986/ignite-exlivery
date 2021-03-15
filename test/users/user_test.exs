defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  import Exlivery.Factory
  alias Exlivery.Users.User

  describe "build/4" do
    test "returns a new user, when the parameters are valid" do
      assert {:ok, user} =
               User.build(
                 "John Doe",
                 "john.doe@exlivery.com",
                 "00822245788",
                 34,
                 "Rua Elixir, 2021"
               )

      assert user == build(:user)
    end

    test "returns an error, when age under 18" do
      %User{name: name, email: email, cpf: cpf, address: address} = build(:user)

      assert {:error, "invalid parameters"} = User.build(name, email, cpf, 17, address)
    end

    test "returns an error, when cpf not is string" do
      %User{name: name, email: email, address: address} = build(:user)

      assert {:error, "invalid parameters"} = User.build(name, email, 9999, 18, address)
    end
  end
end
