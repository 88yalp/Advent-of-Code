function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 5")
    
    #file = "example_dataset.txt"
    file = "dataset.txt"
    
    rules = Dict{Int, Set{Int}}()
    orderings = Vector{Vector{Int}}()
    extract_data!(file, rules, orderings)
    
    invalid_orders = Vector{Vector{Int}}()
    for order in orderings
        if !is_valid(order, rules)
            push!(invalid_orders, order)
        end
    end

    total = 0
    for order in invalid_orders
        midpoint = ((-1 + length(order)) ÷2)
        for page in order 
            if length(intersect(Set(order), get(rules, page, Set()))) == midpoint
                total += page
                break
            end
        end
    end
    return total
end


function extract_data!(file::String, rules::Dict{Int, Set{Int}}, orderings::Vector{Vector{Int}})
    open(file, "r") do f
        for line in readlines(file)
            if occursin("|", line)
                page1, page2 = split(line, "|")
                page1, page2 = parse(Int, page1), parse(Int, page2)
                rules[page1] = union(get(rules, page1, Set{Int}(page2)), (page2))
            elseif occursin(",", line)
                order = split(line, ",")
                order = parse.(Int, order) 
                push!(orderings, order)
            end
        end
    end
end

function is_valid(order::Vector{Int}, rules::Dict{Int, Set{Int}}) 
    seen = Set{Int}()
    for page in order
        union!(seen, page)
        if !(intersect(get(rules, page, Set()), seen) == Set{Int}())
            return false
        end
    end
    return true
end




print(main())
