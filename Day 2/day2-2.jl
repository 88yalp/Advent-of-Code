using CSV, DataFrames

function is_safe(deltas::Vector, can_recurse::Bool)
    if sum(0 .< deltas .< 4) == length(deltas)
        return 1
    end
    if sum(-4 .< deltas .< 0) == length(deltas)
        return 1
    end
    if can_recurse
        if is_safe(deltas[2:end], false) == 1
            return 1
        elseif is_safe(deltas[1:end-1], false) == 1 
            return 1
        else 
            return subreport_is_safe(deltas)
        end
    end
    return 0
end
    
function subreport_is_safe(deltas)
    for index in range(2,stop = length(deltas))
        new_deltas = [deltas[1:index-1]; deltas[index + 1 : end]]
        new_deltas[index-1] = deltas[index - 1]  + deltas[index]
        if is_safe(new_deltas, false) == 1 return 1
        end 
    end
    return 0
end


cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 2")

file = "reports.csv"
df = CSV.read(file, DataFrame)

safe = 0
for row in df[!, :Reports]
    report = parse.(Int, split(row, " "))
    deltas = Array{Int64,1}(undef, length(report)-1)
    for (index, num) in zip(Iterators.countfrom(0), report)
        if index != 0
            deltas[index] = (num - report[index])
        end
    end
    global safe = safe + is_safe(deltas, true) 
end
safe