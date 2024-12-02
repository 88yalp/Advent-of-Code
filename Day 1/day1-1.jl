using CSV, DataFrames

cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 1")

file = "lists.csv"
df = CSV.read(file, DataFrame)


list1 = df[:,:list1]
list2 = df[:,:list2]
sort!(list1)
sort!(list2)

distances = abs.(list1 -list2)

sum(distances)