defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case
  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  setup do
    UserAgent.start_link(%{})

    build(:user, cpf: "00988877766")
    |> UserAgent.save()

    :ok
  end

  describe "save/1" do
    test "saves the user" do
      user = build(:user, cpf: "00993208027")
      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    test "return an user" do
      assert {:ok,
              %User{
                address: "Rua Elixir, 2021",
                age: 34,
                cpf: "00988877766",
                email: "john.doe@exlivery.com",
                name: "John Doe"
              }} = UserAgent.get("00988877766")
    end

    test "return an error, when cpf not found" do
      assert {:error, :user_not_found} = UserAgent.get("cpf-nonexistent")
    end
  end
end
