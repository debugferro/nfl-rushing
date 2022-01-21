defmodule NflRushing.Player do
  @moduledoc """
  The Player context.
  """

  import Ecto.Query, warn: false
  alias NflRushing.Repo
  alias NflRushing.Player.{Rushing, SortingError}

  def get_all() do
    Rushing
    |> Repo.all
  end

  def get_rushing_ordered_by(sort_args) do
    Rushing
    |> add_order_by_queries(sort_args)
    |> IO.inspect()
    |> Repo.all
  end

  def search_by_name(searched_name) do
    from(pr in Rushing ,
    where: fragment("? % ?", pr.player, ^searched_name),
    order_by: fragment("similarity(?, ?) DESC", pr.player, ^searched_name))
    |> Repo.all
  end

  def search_by_name(searched_name, sort_args) do
    from(pr in Rushing ,
    where: fragment("? % ?", pr.player, ^searched_name))
    |> add_order_by_queries(sort_args)
    |> IO.inspect(label: "QUERY")
    |> Repo.all
  end

  defp add_order_by_queries(query, %{"asc" => asc_fields, "desc" => desc_fields}) do
    add_order_by_query(query, asc_fields, :asc)
    |> add_order_by_query(desc_fields, :desc)
  end

  defp add_order_by_queries(query, %{"asc" => field}) do
    add_order_by_query(query, field, :asc)
  end

  defp add_order_by_queries(query, %{"desc" => field}) do
    add_order_by_query(query, field, :desc)
  end

  defp add_order_by_query(query, [], _sort_type), do: query
  defp add_order_by_query(query, [field|others], sort_type) do
    atomized_field = field_to_atom(field)

    query
    |> order_by([{^sort_type, ^atomized_field}])
    |> add_order_by_query(others, sort_type)
  end

  defp field_to_atom("total_yards"), do: :total_yards
  defp field_to_atom("longest_rush"), do: :longest_rush
  defp field_to_atom("total_touchdowns"), do: :total_touchdowns
  defp field_to_atom(_any), do: raise(SortingError)
end
