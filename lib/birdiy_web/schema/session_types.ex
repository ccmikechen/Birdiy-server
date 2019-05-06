defmodule BirdiyWeb.Schema.SessionTypes do
  use Absinthe.Schema.Notation

  input_object :login_input do
    field :method, non_null(:login_method)
    field :credential, non_null(:string)
  end

  enum :login_method do
    value(:facebook)
    value(:google)
  end

  object :session do
    field :user, non_null(:viewer)
    field :access_token, non_null(:string)
    field :refresh_token, non_null(:string)
  end

  input_object :refresh_session_input do
    field :refresh_token, non_null(:string)
  end

  object :refresh_session_result do
    field :access_token, non_null(:string)
  end
end
