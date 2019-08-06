defimpl ExAdmin.Authentication, for: Plug.Conn do
  alias BirdiyWeb.Router.Helpers, as: Routes
  alias Birdiy.Accounts.Admin

  def use_authentication?(_), do: true
  def current_user(conn), do: Pow.Plug.current_user(conn)

  def current_user_name(conn) do
    case Pow.Plug.current_user(conn) do
      %Admin{email: email} -> email
      _ -> nil
    end
  end

  def session_path(conn, action), do: Routes.pow_session_path(conn, action)
end
