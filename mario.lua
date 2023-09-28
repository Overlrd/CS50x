-- https://cs50.harvard.edu/x/2023/psets/1/mario/more/

function main()
  local height = nil;
  repeat
    io.write("Height: ")
    height = io.read("n")
  until height >= 1 and height <= 8

    draw(height)
end

function draw(height)
  for i=1, height do
    local num_tags = i;
    local num_spaces = (height - i)
    local line = ""
    line = line .. string.rep(" ", num_spaces)
    line = line .. string.rep("#", num_tags)
    line = line .. "  "
    line = line .. string.rep("#", num_tags)
    print(line)
  end
end


main()


