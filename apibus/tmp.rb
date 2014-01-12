require "json"


hash = {}

hash["name"] = "name_"
hash["action"] = "action_"
hash["resource"] = "resource_"

p hash
puts hash.delete("name")
p hash