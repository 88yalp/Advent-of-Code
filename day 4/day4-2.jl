cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 4")

file = "wordsearch.txt"


open(file, "r") do f
    global wordsearch = readlines(file)
end

function is_Xmas(wordsearch::Vector{String}, position::Vector{Int})
    primary_diagonal = wordsearch[position[1]-1][position[2]-1] * wordsearch[position[1]+1][position[2]+1]
    secondary_diagonal = wordsearch[position[1]-1][position[2]+1] * wordsearch[position[1]+1][position[2]-1]
    if occursin(r"(SM)|(MS)",primary_diagonal)
        if occursin(r"(SM)|(MS)",secondary_diagonal)
            return 1
        end
    end
    return 0
end

function find_A(wordsearch::Vector{String})
    count = 0
    for (j, row) in enumerate(wordsearch), (i, letter) in enumerate(row)
        if !checkbounds(Bool, wordsearch, [j-1, i-1]) || !checkbounds(Bool, wordsearch, [j+1, i+1]) 
            continue
        elseif letter == 'A'
            count += is_Xmas(wordsearch, [j,i])
        end 
    end
    return count 
end

find_A(wordsearch)