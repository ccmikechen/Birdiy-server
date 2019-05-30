alias Birdiy.{Repo, Diy}

project_topics = %{
  "Craft" => [
    "Art",
    "Books",
    "Cardboard",
    "Card",
    "Clay",
    "Puppet",
    "Gift Wrapping",
    "Miniature Art",
    "Embroidery",
    "Groceries",
    "Toys",
    "Stamps",
    "Wood Carving",
    "Origami",
    "Papercraft",
    "Knitting",
    "Tailoring",
    "Accessories",
    "Patchwork",
    "Leather",
    "Props",
    "Floral Design",
    "Handmade Soap",
    "Candles",
    "Models"
  ],
  "Workshop" => [
    "3D Printing",
    "Woodworking",
    "Furnitures",
    "Cars",
    "Motorcycles",
    "CNC",
    "Energy",
    "Home Improvement",
    "Knives",
    "Metalworking",
    "Laser Cutting",
    "Lighting",
    "Repair",
    "Solar",
    "Tools"
  ],
  "Electronics" => [
    "Computers",
    "Robots",
    "Cameras",
    "Arduino",
    "Raspberry Pi",
    "Clocks",
    "Electric Circuits",
    "Gadgets",
    "LED",
    "Mobile",
    "Smartphones",
    "Speakers",
    "Software",
    "Wearables",
    "Wireless",
    "Digital Art"
  ],
  "Living" => [
    "Cleaning",
    "Organizing",
    "Storage",
    "Hairdressing",
    "Festival",
    "Decorating",
    "Education",
    "Gardening",
    "Health",
    "Hiding Places",
    "Holiday",
    "Kitchen",
    "Life Hacks",
    "Music",
    "Pets",
    "Travel"
  ],
  "Outside" => [
    "Beach",
    "Bikes",
    "Camping",
    "Climbing",
    "Fishing",
    "Kites",
    "Knots",
    "Launchers",
    "Rockets",
    "Skateboarding",
    "Sports",
    "Survival"
  ],
  "Science" => [
    "Chemistry",
    "Electricity",
    "Electromagnetism",
    "Bubble",
    "Thermology",
    "Air",
    "Optics",
    "Sound",
    "Mechanics",
    "Water",
    "Paper"
  ]
}

now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

topics_to_insert =
  Enum.map(project_topics, fn {category, topics} ->
    %{id: category_id} = Diy.get_project_category_by_name!(category)

    Enum.map(topics, fn topic ->
      %{category_id: category_id, name: topic, inserted_at: now, updated_at: now}
    end)
  end)
  |> List.flatten()

Repo.insert_all(Diy.ProjectTopic, topics_to_insert, on_conflict: :nothing)
