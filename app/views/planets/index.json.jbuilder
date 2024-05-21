json.array! @planets do |planet|
  json.extract! planet, :id, :name
end