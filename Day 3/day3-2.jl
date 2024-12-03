
cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 3")

file = "corrupted_memory.txt"

open(file, "r") do f
    global corrupted_memory = read(f,String)
end

re = r"(mul\((\d+),(\d+)\))|(do\(\))|(don't\(\))"m

matches = eachmatch(re, corrupted_memory)

results = 0
accepting = true
for m in matches
    mul, factor1, factor2, accept, reject = m.captures

    if accepting
        if !isnothing(reject)
            global accepting = false
        end
        if !isnothing(factor1) && !isnothing(factor2)
            global results += parse(Int, factor1) * parse(Int, factor2)
        end
    else
        if !isnothing(accept)
            global accepting = true
        end
    end
end
results