defmodule Stripe.Balance do
  @moduledoc """
  Work with Stripe balance objects.

  You can:
  - Retrieve a balance


  Stripe API reference: https://stripe.com/docs/api#balance
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :available, :connect_reserved, :pending
  ]

  @plural_endpoint "balances"
  @singular_endpoint "balance"

  @balance_map %{
    currency: [:retrieve], 
    amount: [:retrieve],
    source_types: [:retrieve],
  }

  @connect_reserved_map %{
    currency: [:retrieve], 
    amount: [:retrieve]
  }

  @schema %{
    available: @balance_map,
    connect_reserved: @connect_reserved_map,
    pending: @balance_map
  }

  @nullable_keys [
    :connect_reserved
  ]

  @doc """
  Retrieve a balance.
  """
  @spec retrieve(Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(opts \\ []) do
    endpoint = @singular_endpoint
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Retrieve a balance for an account id.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) when is_binary(id) do
    Keyword.put_new([opts, :connect_account, id)
    endpoint = @singular_endpoint
    Stripe.Request.retrieve(endpoint, opts)
  end
end
