function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 7")
    
    #file = "example_dataset.txt"
    file = "dataset.txt"

    data = readlines(file)

    answer = 0
    for equation in data
        total, arguments = separate_data(equation)
        if is_possible(total, arguments)
            answer += total 
        end
    end
    return answer
end

function separate_data(equation::String)
    total = parse(Int, equation[findfirst(r"\d+", equation)])
    arguments = split(equation, ": ")[2]
    arguments = parse.(Int, split(arguments, " "))
    return total, arguments 
end

function is_possible(total::Int, arguments::Vector{Int})
    available_operations =  ['+','*']
    for i in 0:(2^(length(arguments)-1)-1)
        arguments_copy = copy(arguments)
        choices = digits(Int, i; base = 2, pad = (length(arguments)-1))
        operations = [available_operations[choice+1] for choice in choices]
        for i in eachindex(operations)
            if operations[i] == '+'
                arguments_copy[1] = arguments_copy[1] + arguments_copy[i+1]
            else
                arguments_copy[1] = arguments_copy[1] * arguments_copy[i+1]
            end
        end
        if arguments_copy[1] == total
            return true
        end
    end
    return false
end


println(main())