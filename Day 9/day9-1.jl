function main()
    cd("C:\\Users\\sunga\\OneDrive - University of Bergen\\fritid\\koding\\Advent-of-Code\\Day 9")
    
    #file = "example_dataset.txt"
    file = "dataset.txt"
    
    data = read(file, String)

    disk_map = uncompress(data) 

    disk_map = rearrange(disk_map)

    checksum = find_checksum(disk_map)
    
    return checksum
    
end

function uncompress(data::String)
    digits = split(data, "")
    disk_space = parse.(Int, digits[1:end-2])
    disk_map = Vector{Int}()
    is_file_block = true
    blocknumber = 0
    for indicator in disk_space
        if is_file_block
            append!(disk_map, fill(blocknumber, indicator))
            blocknumber += 1
        else
            append!(disk_map, fill(-1, indicator))
        end
        is_file_block = ! is_file_block
    end
    return disk_map
end

function rearrange(disk_map::Vector{Int})
    is_negative(x) = x <  0
    is_non_negative(x) = x >= 0

    left = findfirst(is_negative, disk_map)
    right = findlast(is_non_negative, disk_map)

    while left < right
        disk_map[left], disk_map[right] = disk_map[right], disk_map[left] 

        left = findnext(is_negative, disk_map, left)
        right = findprev(is_non_negative, disk_map, right)

    end
    return disk_map
end

function find_checksum(disk_map::Vector{Int})
    checksum = 0
    for (index, fileID) in zip(Iterators.countfrom(0), disk_map)
        if fileID == -1
            break
        end
        checksum += index * fileID
    end
    return checksum
    
end
    
    
print(main())
