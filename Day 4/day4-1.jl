cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 4")

file = "wordsearch.txt"

open(file, "r") do f
    global wordsearch = readlines(file)
end


function find_word(wordsearch::Vector{String}, word::String, position::Vector{Int}, change::Vector{Int})
    for (letter, index) in zip(word, Iterators.countfrom(0))
        indexes = position + index*change
        if !checkbounds(Bool, wordsearch, indexes)
            return 0
        elseif !(wordsearch[indexes[1]][indexes[2]] == letter)
            return 0
        end
    end
    return 1
end

    


function find_letter(wordsearch::Vector{String}, word::String, search_letter::Char)
    count = 0
    for (j, row) in enumerate(wordsearch), (i, letter) in enumerate(row)
        if letter == search_letter
            for (k, p) in Iterators.product(range(-1, stop = 1), range(-1, stop = 1))
                count += find_word(wordsearch, word, [j,i], [k,p])
            end 
        end 
    end
    return count 
end

find_letter(wordsearch, "XMAS", 'X')