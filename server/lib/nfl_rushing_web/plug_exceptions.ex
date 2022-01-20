alias NflRushing.Player.SortingError

defimpl Plug.Exception, for: SortingError do
  def status(_exception), do: 400
end
