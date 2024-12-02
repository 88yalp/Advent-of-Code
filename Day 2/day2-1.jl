using CSV, DataFrames

function is_safe(deltas::Vector)
    if sum(0 .< deltas .< 4) == length(deltas)
        return 1
    end
    if sum(-4 .< deltas .< 0) == length(deltas)
        return 1
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
    global safe += is_safe(deltas)
end
safe