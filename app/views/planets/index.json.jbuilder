json.array! @planets do |planet|
  json.extract! planet, :name
end