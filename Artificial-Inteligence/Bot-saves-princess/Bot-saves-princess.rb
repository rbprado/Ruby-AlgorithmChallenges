#!/bin/ruby

def findPosition(grid, char)
    grid.each_with_index do |line, y|
        x = line.index(char)

        if not x.nil?
            return [y,x]
        end
    end
end

def distanceCalc(m,p)
    x = (m[1] - p[1])
    y = (m[0] - p[0])
    
    return [y, x]
end

def decidePath(m,p)
    distance = distanceCalc(m,p)
    
    if distance[1].abs > distance[0].abs
        if distance[1] > 0
            return 'LEFT'
        else
            return 'RIGHT'
        end
    else
        if distance[0] > 0
            return 'UP'
        else
            return 'DOWN'
        end
    end
end

def updateGrid(grid, path)
    m = findPosition(grid, 'm')
    #STDERR.puts grid.inspect
    if path == 'RIGHT'
        grid[m[0]][m[1]] = '-'
        m[1] += 1
        grid[m[0]][m[1]] = 'm'
    elsif path == 'LEFT'
        grid[m[0]][m[1]] = '-'
        m[1] -= 1
        grid[m[0]][m[1]] = 'm'
    elsif path == 'UP'
        grid[m[0]][m[1]] = '-'
        m[0] -= 1
        grid[m[0]][m[1]] = 'm'
    elsif path == 'DOWN'
        grid[m[0]][m[1]] = '-'
        m[0] += 1
        grid[m[0]][m[1]] = 'm'
    end
    return grid
end

def distanceTurns(m,p)
    distance = distanceCalc(m,p)
    return distance[1].abs + distance[0].abs
end

def displayPathtoPrincess(grid)
    m = findPosition(grid, 'm')
    p = findPosition(grid, 'p')
    path = []
    (1..distanceTurns(m, p)).each do
        path << decidePath(m,p)
        grid = updateGrid(grid, decidePath(m,p))
        m = findPosition(grid, 'm')
        p = findPosition(grid, 'p')
    end
    path.each do |x|
        puts x
    end
end

m = gets.to_i
grid = Array.new(m) { Array.new(m) }
grid.each_index do |x|
    gets.strip.each_char.with_index do |char, y|
        grid[x][y] = char
    end
end

displayPathtoPrincess(grid)
