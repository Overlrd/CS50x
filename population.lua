-- implementation of CS50x Week 1 - lab - population
MIN_POPULATION = 9;

local function main ()
  local starting_pop_size;
  local ending_pop_size;
  -- prompt the user for a population size 
  repeat
    print("Enter the starting population size: ")
    starting_pop_size = io.read("n")
  until  starting_pop_size ~= nil and starting_pop_size >= 9

  repeat
    print("Enter the ending population size: ")
    ending_pop_size = io.read("n")
  until ending_pop_size ~= nil and ending_pop_size > starting_pop_size

  local num_years = 0;
  while starting_pop_size < ending_pop_size do
    starting_pop_size = starting_pop_size + math.floor((starting_pop_size / 3)) - math.floor((starting_pop_size / 4))
    num_years = num_years + 1
  end
  print("Years :", num_years)
end

main()
