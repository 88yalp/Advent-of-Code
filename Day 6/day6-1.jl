import Base.:+

function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 6")
    
    #file = "example_dataset.txt"
    file = "dataset.txt"

    layout = read(file, String)

    cols = findfirst('\n', layout) + 1
    rows = length(split(layout, "\n")) - 1 

    guards = ['^', '>', 'v', '<']
    guard_index = find_guard(guards, layout)
    directions = [(-1, 0), (0, 1), (1, 0), (0,-1)]
    
    cords = index_to_cords(findfirst(guards[guard_index], layout), cols)

    while is_in_layout(cords, cols, rows)
    #for _ in 1:10 
        if can_continue(cords, cols, rows, directions[guard_index], layout)
            layout = join([layout[1:cords_to_index(cords, cols)-1], "X", layout[cords_to_index(cords,cols)+ 1:end]])
            cords += directions[guard_index]
            if is_in_layout(cords, cols, rows)
                layout = join([layout[1:cords_to_index(cords, cols)-1], guards[guard_index], layout[cords_to_index(cords,cols)+ 1:end]])
            end
        else 
            guard_index, layout = rotate(guard_index, guards, cords, cols, layout)
        end
    end
    
    return count(i -> (i=='X'), layout)


end

function rotate(guard_index::Int, guards::Vector{Char}, cords::Tuple{Int, Int},cols::Int,  layout::String)
    guard_index += 1
    if guard_index > 4
        guard_index = 1
    end
    return guard_index, join([layout[1:cords_to_index(cords, cols)-1], guards[guard_index], layout[cords_to_index(cords,cols)+ 1:end]])

end

function index_to_cords(index::Int, cols::Int) 
    row, col  = fldmod1(index-1, cols-1)
    return row, col+1
end

function cords_to_index((row, col)::Tuple{Int, Int}, cols::Int)
    return (row-1) * (cols-1) + col 
end

function find_guard(guards::Vector{Char},layout::String)
    
    for (index, guard) in enumerate(guards)
        if occursin(guard, layout)
            return index
        end
    end
end

function can_continue(cords::Tuple{Int, Int}, cols::Int, rows::Int, direction::Tuple{Int, Int}, layout::String)
    next = (cords[1] + direction[1], cords[2] + direction[2])
    index = cords_to_index(next, cols)
    if ! is_in_layout(next, cols, rows)
        return true
    end
    if layout[index] == '#'
        return false

    end 
    return true
end

function is_in_layout(cords::Tuple{Int, Int}, cols::Int, rows::Int)
    if cords[1] < 1 || cords[1] > rows
        return false
    end
    if cords[2] < 1 || cords[2] > cols - 2
        return false
    end
    return true
end

function +(a::Tuple{Int, Int}, b::Tuple{Int, Int})
    return (a[1]+b[1], a[2] + b[2])
    
end

println(main())