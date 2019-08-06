defmodule BirdiyWeb.Admin.Accounts.Admin do
  use ExAdmin.Register

  register_resource Birdiy.Accounts.Admin do
    index do
      selectable_column()

      column(:id)
      column(:email)

      actions()
    end

    show admin do
      attributes_table do
        row(:id)
        row(:email)
        row(:password_hash)
      end
    end

    form admin do
      inputs do
        input(admin, :email)
        input(admin, :password)
        input(admin, :confirm_password)
      end
    end
  end
end
