import Base.+,Base.-

function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 8")
    
    #file = "example_dataset.txt"
    file = "dataset.txt"

    layout = read(file, String)

    global cols = findfirst('\n', layout) -2
    global rows = length(split(layout, "\n")) - 1 


    re = r"\w"

    antinodes = Set{Int}()
    
    for source_frequency in eachmatch(re, layout)
        
        source_cords = index_to_cords(source_frequency.offset, true)
        
        for sink_frequency in eachmatch(Regex(source_frequency.match), layout)
            if source_frequency.offset == sink_frequency.offset
                continue
            end

            sink_cords = index_to_cords(sink_frequency.offset, true)
            delta_cords = sink_cords - source_cords     
            
            antinode_cords = sink_cords 
            while is_in_layout(antinode_cords)
                union!(antinodes, [cords_to_index(antinode_cords)])
                antinode_cords = antinode_cords + delta_cords 
            end
        end
    end
    #return antinodes
    return length(antinodes)
end


function index_to_cords(index::Int, handle_newline::Bool) 
    if handle_newline
        row, col  = fldmod1(index, cols+2)
    else
        row, col  = fldmod1(index, cols)
    end
    return row, col
end

function cords_to_index((row, col)::Tuple{Int, Int})
    return (row-1) * (cols) + col 
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

print(main())

# for i in 1:150
#     println(i, "->", index_to_cords(i))
# end