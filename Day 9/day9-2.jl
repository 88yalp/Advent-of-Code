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
    is_non_negative(x) = x>=0
    lastID = disk_map[findlast(is_non_negative, disk_map)]

    for id in lastID:-1:1
        f(x) = x == id
        right_start = findfirst(f, disk_map)
        right_end = findlast(f, disk_map)
        
        right = right_start:right_end
        left = find_first_match(fill(-1, length(right)), disk_map[1:right_start])
        if left == false
            continue
        end

        disk_map[left], disk_map[right] = disk_map[right], disk_map[left] 

    end
    return disk_map
end

function find_checksum(disk_map::Vector{Int})
    checksum = 0
    for (index, fileID) in zip(Iterators.countfrom(0), disk_map)
        if fileID == -1
            continue
        end
        checksum += index * fileID
    end
    return checksum
    
end

function find_first_match(find::Vector{Int}, search::Vector{Int})

    
    for (left,_) in enumerate(search)
        for (index, value) in zip(Iterators.countfrom(0), find)
            if search[left + index] == value
                if index == length(find) - 1

                    return left:left+length(find)-1
                end
                continue
            else
                left += 1
                break
            end
        end
    end
    return false
end



    
    
print(main())
