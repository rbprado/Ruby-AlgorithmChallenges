#!/bin/ruby

def findAllDirty(grid, char)
    dirty = []
    grid.each.with_index do |line, y|
        line.each.with_index do |c, x|
            if c == char
                dirty << [y,x]
            end
        end
    end
    return dirty
end

def distanceCalc(bot, dirty)
    x = (bot[1] - dirty[1])
    y = (bot[0] - dirty[0])
    return [y, x]
end

def dirtyChooser(bot, dirty)
    dirty_dist, abs_dist = [], []
    dirty.each.with_index do |d_pos, idx|
        dirty_dist[idx] = distanceCalc(bot, d_pos)
        abs_dist[idx]   = dirty_dist[idx][1].abs + dirty_dist[idx][0].abs
    end
    return dirty_dist.at(abs_dist.index(abs_dist.min))
end

def decidePath(bot, dirty)
    distance = dirtyChooser(bot, dirty)
    
    if distance[1] == 0 and distance[0] == 0
        return 'CLEAN'
    elsif distance[1].abs > distance[0].abs
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

def next_move(bot_x, bot_y, grid)
    dirty = findAllDirty(grid, 'd')
    bot = [bot_x, bot_y]

    return decidePath(bot, dirty)
end

bot = gets.split.map {|i| i.to_i}
matrix = gets.split.map {|i| i.to_i}
grid = Array.new(matrix[0]) do
    Array.new(matrix[1])
end

grid.each_index do |y|
    gets.strip.each_char.with_index do |char, x|
        grid[y][x] = char
    end
end

puts next_move(bot[0], bot[1], grid)
