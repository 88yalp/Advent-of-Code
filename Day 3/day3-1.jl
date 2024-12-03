
cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 3")

file = "corrupted_memory.txt"

open(file, "r") do f
    global corrupted_memory = read(f,String)
end


re = r"mul\((\d+),(\d+)\)"m

matches = eachmatch(re, corrupted_memory)

results = 0
for m in matches
    factor1, factor2 = m.captures
    factor1 = parse(Int, factor1)
    factor2 = parse(Int, factor2)
    global results += factor1 * factor2
end
results