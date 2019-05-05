defmodule Birdiy.Guardian do
  use Guardian, otp_app: :birdiy

  alias Birdiy.Accounts

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    {:ok, Accounts.get_user(id)}
  end
end
