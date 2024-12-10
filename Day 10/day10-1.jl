import Base.+,Base.-

function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 10")
    
    #file = "example_dataset.txt"
    file = "dataset.txt"
    
    layout = read(file, String)

    global cols = findfirst('\n', layout) -2
    global rows = length(split(layout, "\n")) - 1 

    answer = 0
    
    for source_frequency in eachmatch(r"0", layout)
        answer += find_unique_tops(source_frequency.offset, layout)
    end

    return answer
    
end

function find_unique_tops(trailhead::Int, layout::String)
    tops = Set{Int}()

    union!(tops, find_tops(index_to_cords(trailhead), layout))

    return length(tops)
end 

function find_tops(cords::Tuple{Int, Int}, layout::String)
    if parse(Int, layout[cords_to_index(cords)]) == 9
        return Set{Int}(cords_to_index(cords))
    end
    directions = [(-1, 0), (0, -1), (0, 1), (1, 0)]
    tops = Set{Int}()

    for direction in directions
        new_cords = cords + direction
        if is_in_layout(new_cords)
            if parse(Int, layout[cords_to_index(cords)]) + 1 == parse(Int, layout[cords_to_index(new_cords)]) 
                union!(tops, find_tops(new_cords, layout))
            end
        end
    end
    return tops
end
    

function index_to_cords(index::Int) 
    return  fldmod1(index, cols+2)
end

function cords_to_index((row, col)::Tuple{Int, Int})
    return (row-1) * (cols+2) + col 
end

function is_in_layout(cords::Tuple{Int, Int})
    if cords[1] < 1 || cords[1] > rows
        return false
    end
    if cords[2] < 1 || cords[2] > cols 
        return false
    end
    return true
end

function +(a::Tuple{Int, Int}, b::Tuple{Int, Int})
    return (a[1]+b[1],a[2]+b[2])
end

function -(a::Tuple{Int, Int}, b::Tuple{Int, Int})
    return (a[1]-b[1],a[2]-b[2])
end
    
println(main())
