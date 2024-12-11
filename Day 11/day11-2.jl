function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 11")
    
    #file = "example_dataset.txt"
    file = "dataset.txt"
    
    stones = parse.(Int, split(read(file, String), " "))[1:end]

    counts = Dict{Int, Int}()

    for stone in stones
        counts[stone] = get(counts, stone, 0) + 1
    end

    for _ in 1:75
        counts = blink(counts)
    end

    return sum(values(counts))
    
end

function blink(counts::Dict{Int, Int})
    new_counts = Dict{Int, Int}()

    for stone in keys(counts)
        new_stone = process_stone(stone)
        if length(new_stone) == 1
            new_counts[new_stone] = get(new_counts, new_stone, 0) + get(counts, stone, 0)
        else
            new_counts[new_stone[1]] = get(new_counts, new_stone[1], 0) + get(counts, stone, 0)
            new_counts[new_stone[2]] = get(new_counts, new_stone[2], 0) + get(counts, stone, 0)
        end
    end
    return new_counts
end

function process_stone(stone::Int)
    
    if stone == 0
        return 1
    elseif is_even_length(stone)
        return split_stone(stone)
    else
        return 2024 * stone
    end
end

function split_stone(stone::Int)
    numbers = digits(stone) 

    half = length(numbers) ÷ 2

    first_stone = sum(numbers[k+half]*10^(k-1) for k in 1:half)
    second_stone = sum(numbers[k]*10^(k-1) for k in 1:half)

    return first_stone, second_stone
end

function is_even_length(stone::Int)
    numbers = digits(stone) 
    return length(numbers)%2 == 0
end
    
println(main())

