using CSV, DataFrames, StatsBase

cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 1")

file = "lists.csv"
df = CSV.read(file, DataFrame)

countslist1 = countmap(df[:,:list1])
countslist2 = countmap(df[:,:list2])

similarityscore = 0
for (number, counts) in countslist1
    global similarityscore += number * counts * get(countslist2, number, 0)
end
similarityscore