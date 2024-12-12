import Base.+,Base.-

function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 12")
    
    #file = "example_dataset.txt"
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
        area, perimeter = determine_fence_cost(cords, plant, layout)

        answer += area * perimeter

        union!(seen, Set{Int}(cords_to_index(cords)))
    end
 
    return answer    
    
end



function determine_fence_cost(cords::Tuple{Int, Int}, plant::Char, layout::String)
    area = 1
    perimeter = 0
    union!(seen, cords_to_index(cords))

    directions = [(-1, 0), (0, -1), (0, 1), (1, 0)]

    for direction in directions
        new_cords = cords + direction
        if ! is_in_layout(new_cords)
            perimeter += 1
            continue
        elseif cords_to_index(new_cords) in seen
            if layout[cords_to_index(new_cords)] != plant
                perimeter += 1
            end
            continue
        elseif layout[cords_to_index(new_cords)] == plant
            area, perimeter += determine_fence_cost(new_cords, plant, layout)
        else 
            perimeter += 1
        end
    end
    return area, perimeter
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
