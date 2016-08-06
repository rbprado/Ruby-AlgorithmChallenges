#!/bin/ruby

def findPosition(grid, char)
    grid.each_with_index do |line, y|
        x = line.index(char)

        if not x.nil?
            return [y,x]
        end
    end
end

def distanceCalc(m, p)
    x = (m[1] - p[1])
    y = (m[0] - p[0])
    return [y, x]
end

def decidePath(m,p)
    distance = distanceCalc(m, p)
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

def displayPathtoPrincess(grid)
    m = findPosition(grid, 'm')
    p = findPosition(grid, 'p')
    puts decidePath(m,p)
end

matrix = gets.to_i
bot    = gets
grid   = Array.new(matrix) { Array.new(matrix) }

grid.each_index do |x|
    gets.strip.each_char.with_index do |char, y|
        grid[x][y] = char
    end
end

displayPathtoPrincess(grid)
