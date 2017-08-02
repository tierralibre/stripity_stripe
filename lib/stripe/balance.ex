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

  @doc """
  Retrieve your own balance without options.
  """
  @spec retrieve :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve, do: retrieve([])

  @doc """
  Retrieve your own balance with options.
  """
  @spec retrieve(list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(opts) when is_list(opts), do: do_retrieve(@singular_endpoint, opts)

  @doc """
  Retrieve a balance for an account with a specified `id`.
  """
  @spec retrieve(binary, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []), do: do_retrieve(@singular_endpoint, id, opts)

  @spec do_retrieve(String.t, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  defp do_retrieve(endpoint, opts), do: Stripe.Request.retrieve(endpoint, opts)

  @spec do_retrieve(String.t, binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  defp do_retrieve(endpoint, id, opts) when is_binary(id) do
    Keyword.put_new(opts, :connect_account, id)
    Stripe.Request.retrieve(endpoint, opts)
  end
end
