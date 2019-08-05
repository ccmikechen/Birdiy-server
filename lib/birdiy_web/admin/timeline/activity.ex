defmodule BirdiyWeb.Admin.Timeline.Activity do
  use ExAdmin.Register

  register_resource Birdiy.Timeline.Activity do
    form activity do
      inputs do
        input(activity, :project_id)
        input(activity, :post_id)
      end
    end
  end
end
