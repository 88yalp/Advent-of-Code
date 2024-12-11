function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 11")
    
    #file = "example_dataset.txt"
    file = "dataset.txt"
    
    stones = parse.(Int, split(read(file, String), " "))[1:end]

    for i in 1:25
        stones = blink(stones)
        #println("After ", i, " blinks, the stones are ", stones )
    end

    return length(stones)

    
end

function blink(stones::Vector{Int})
    new_stones = Vector{Int}()

    for stone in stones
        if stone == 0
            push!(new_stones, 1)
        elseif is_even_length(stone)
            append!(new_stones, split_stone(stone))
        else
            push!(new_stones, 2024 * stone)
        end
    end
    return new_stones
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

