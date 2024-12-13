import Base.+,Base.-

function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 12")
    
    # file = "example_dataset.txt"
    file = "dataset.txt"
    
    layout = read(file, String)

    global cols = findfirst('\n', layout) -2
    global rows = length(split(layout, "\n")) - 1 
    global seen = Set{Int}()

    answer = 0

    for (index, plant) in enumerate(layout) 
        cords = index_to_cords(index)
        if ! is_in_layout(cords)
            continue
        end
        if cords_to_index(cords) in seen
            continue
        end
        area, sides = determine_fence_cost(cords, plant, layout)
        answer += area * sides

        union!(seen, Set{Int}(cords_to_index(cords)))
    end
 
    return answer    
    
end

function is_in_same_groupe(cords::Tuple{Int, Int}, plant::Char, layout::String)
    if is_in_layout(cords)
        if layout[cords_to_index(cords)] == plant
            return true
        end
    end
    return false
end

function determine_corners(cords::Tuple{Int, Int}, plant::Char, layout::String)
    corners = 0
    directions = [(-1, 0), (0, 1), (1, 0), (0, -1)]

    for (index, direction) in enumerate(directions)
        rotated = directions[mod1(index+1, 4)]  
        new_cords = cords + direction
        new_cords_rotated = cords + rotated
        new_cords_diagonal = cords + direction + rotated

        new_cords_is_same = is_in_same_groupe(new_cords, plant, layout)
        new_cords_rotated_is_same = is_in_same_groupe(new_cords_rotated, plant, layout)
        new_cords_diagonal_is_same = is_in_same_groupe(new_cords_diagonal, plant, layout)

        
        if (!new_cords_is_same && !new_cords_rotated_is_same)
            corners += 1
        elseif new_cords_is_same && new_cords_rotated_is_same && !new_cords_diagonal_is_same
            corners += 1
        end
    end
    return corners    
end



function determine_fence_cost(cords::Tuple{Int, Int}, plant::Char, layout::String)
    area = 1
    sides = determine_corners(cords, plant, layout)
    union!(seen, cords_to_index(cords))

    directions = [(-1, 0), (0, 1), (1, 0), (0, -1)]

    for direction in directions
        new_cords = cords + direction
        if ! is_in_layout(new_cords)
            continue
        elseif cords_to_index(new_cords) in seen
            continue
        elseif layout[cords_to_index(new_cords)] == plant
            area, sides += determine_fence_cost(new_cords, plant, layout)
        end
    end
    return area, sides
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
