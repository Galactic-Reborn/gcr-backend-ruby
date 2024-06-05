class MyCustomSerializer
  def dump(value)
    begin

      parsed_json = JSON.parse(value.body)

      JSON.pretty_generate(parsed_json)
          .gsub(/"id":\s"(.*)"/, "\"id\": \"ANY\"")
          .gsub(/"id\\":\\"(.*)\\"/, "\"id\\\":\\\"ANY\\\"")
          .gsub(/"created_at":\s"(.*)"/, "\"created_at\": \"ANY\"")
          .gsub(/"updated_at":\s"(.*)"/, "\"updated_at\": \"ANY\"")
          .gsub(/"address":\s"(.*)"/, "\"address\": \"ANY\"")
          .gsub(/"planet_id":\s"(.*)"/, "\"planet_id\": \"ANY\"")
          .gsub(/"building_end_time":\s*-?\d+/, "\"building_end_time\": \"ANY\"")
          .gsub(/"last_updated":\s*-?\d+/, "\"last_updated\": \"ANY\"")
          .gsub(/"main_planet_id":\s"(.*)"/, "\"main_planet_id\": \"ANY\"")

    rescue JSON::ParserError => e
      { error: "Nieprawidłowy format JSON: #{e.message}" }.to_json
    end
  end
end