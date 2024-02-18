class MyCustomSerializer
  def dump(value)
    begin

      parsed_json = JSON.parse(value.body)

      parsed_json['address'] = 'ANY' if parsed_json['address']


      JSON.pretty_generate(parsed_json)
    rescue JSON::ParserError => e
      { error: "Nieprawidłowy format JSON: #{e.message}" }.to_json
    end
  end
end