defmodule Birdiy.Arc.Resolver do
  defmacro __using__(_) do
    quote do
      def resolver(field) do
        unquote(__MODULE__).resolver(__MODULE__, field)
      end
    end
  end

  def resolver(uploader, field) do
    fn parent, _, _ ->
      field_value = Map.get(parent, field)
      {:ok, uploader.url({field_value, parent})}
    end
  end
end
