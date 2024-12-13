function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 13")
    
    file = "example_dataset.txt"
    file = "dataset.txt"
    
    data = read(file, String)

    machines = find_machines(data)

    cost = find_cost_total(machines) 
    
    return cost
end

struct Claw_machine
    a_x :: Int
    a_y :: Int
    b_x :: Int
    b_y :: Int
    price_x :: Int
    price_y :: Int
end 

function find_cost_total(machines::Array{Claw_machine, 1})
    cost = 0

    for machine in machines
        a = [machine.a_x, machine.a_y]
        b = [machine.b_x, machine.b_y]
        if is_parallel(a,b)
            println("whee")
        end
        
        cost += find_cost(machine)

    end
    return cost

    
end

function find_cost(machine::Claw_machine)
    a = machine.a_x
    b = machine.b_x
    c = machine.a_y
    d = machine.b_y
    p_x = machine.price_x
    p_y = machine.price_y

    determinant = (a * d) - (b * c)
    a_presses = (d * p_x - b*p_y) / determinant
    b_presses = (-c * p_x + a*p_y) / determinant

    if mod(a_presses, 1) != 0.0 || mod(b_presses, 1) !=0.0
        return 0 
    end
    a_presses = round(Int, a_presses)
    b_presses = round(Int, b_presses)

    if !(0<= a_presses)
        return 0
    end
    if !(0<= b_presses)
        return 0
    end
    return a_presses * 3 + b_presses
end

function is_parallel(a::Vector, b::Vector)
    return a[1]/b[1] == a[2]/b[2]    
end

function find_machines(data::String)
    
    machines = Array{Claw_machine, 1}(undef, 0)

    re = r"Button A: X\+(\d+), Y\+(\d+)\r\nButton B: X\+(\d+), Y\+(\d+)\r\nPrize: X=(\d+), Y=(\d+)"

    for machine in eachmatch(re, data)
        
        push!(machines, Claw_machine(
            parse(Int, machine.captures[1]),
            parse(Int, machine.captures[2]),
            parse(Int, machine.captures[3]),
            parse(Int, machine.captures[4]),
            parse(Int, machine.captures[5]) + 10000000000000,
            parse(Int, machine.captures[6]) + 10000000000000))
    end
    return machines
end 

println(main())