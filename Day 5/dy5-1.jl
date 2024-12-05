cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 5")

#file = "example_dataset.txt"
file = "dataset.txt"


global rules = Dict{Int, Set{Int}}()
global Orderings = Vector{Vector{Int}}()

open(file, "r") do f
    for line in readlines(file)
        if occursin("|", line)
            page1, page2 = split(line, "|")
            page1, page2 = parse(Int, page1), parse(Int, page2)
            rules[page1] = union(get(rules, page1, Set{Int}(page2)), (page2))
        elseif occursin(",", line)
            order = split(line, ",")
            order = parse.(Int, order) 
            push!(Orderings, order)
        end
    end
end

function is_valid(order::Vector{Int}, rules::Dict{Int, Set{Int}}) 
    seen = Set{Int}()
    for page in order
        union!(seen, page)
        if !(intersect(get(rules, page, Set()), seen) == Set{Int}())
            return 0
        end
    end
    return order[(1+end)÷2]
end

total = 0
for order in Orderings
    global total += is_valid(order, rules)
end

print(total)

