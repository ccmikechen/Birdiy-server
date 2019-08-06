defmodule BirdiyWeb.Admin.Dashboard do
  use ExAdmin.Register

  register_page "Dashboard" do
    menu(priority: 1, label: "Dashboard")

    content do
      div ".blank_slate_container#dashboard_default_message" do
        span ".blank_slate" do
          span("Welcome to Birdiy admin panel.")
        end
      end
    end
  end
end
