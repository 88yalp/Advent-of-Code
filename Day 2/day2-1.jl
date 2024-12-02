using CSV, DataFrames

cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 2")

file = "reports.csv"
df = CSV.read(file, DataFrame)

safe = 0
for row in df[!, :Reports]
    report = parse.(Int, split(row, " "))
    diffs = Array{Int64,1}(undef, length(report)-1)
    for (index, num) in zip(Iterators.countfrom(0), report)
        if index != 0
            diffs[index] = (num - report[index])
        end
    end
    if sum(0 .< diffs .< 4) == length(diffs)
        global safe += 1
    elseif sum(-4 .< diffs .< 0) == length(diffs)
        global safe += 1
    end
end
safe