-- https://cs50.harvard.edu/x/2023/psets/2/wordle50/
--
GREEN = "\27[38;2;255;255;255;1m\27[48;2;106;170;100;1m"
YELLOW = "\27[38;2;255;255;255;1m\27[48;2;201;180;88;1m"
RED = "\27[38;2;255;255;255;1m\27[48;2;220;20;60;1m"
RESET = "\27[0;39m"
WORDSIZES = {5, 6, 7, 8}
LISTSIZE = 1000 -- each file contains 1000 words

-- values for colors and score (EXACT == right letter, right place; CLOSE == right letter, wrong place; WRONG == wrong letter)
EXACT, CLOSE, WRONG = 2, 1, 0

function main()
  local wordsize
  if arg[1] then
    if type(arg[1]) ~= "number" then wordsize = tonumber(arg[1]) end
    if wordsize == nil then print("Error: wordsize should be an integer !") return end
    if wordsize < 5 or wordsize > 8 then print("Error: wordsize must be either 5, 6, 7, or 8") return end
  else
    print("Usage: ./wordle wordsize")
    return
  end
  -- load the corresponding file and select a random word
  local choice
  do
    local filename = string.format("%s.txt", wordsize)
    local file = io.open(filename,"r")
    if not file then print("Error opening file", filename) return end
    local lines = {}
    for line in io.lines(filename) do
      lines[#lines+1] = line
    end
    local rand = math.random(0, LISTSIZE)
    choice = lines[rand]
  end

  -- allow on more guess than the word size
  local guesses = wordsize + 1
  local won = false;

  -- print greeting using ANSI color codes to demonstrate
  io.write(GREEN,"This is WORDLE-Lua",RESET, "\n")
  io.write(string.format("You have %i tries to guess the %i-letter word i'm thinking of \n", guesses, wordsize))
  print(choice)


  -- game main loop 
  for i=1, guesses do
    local guess = get_guess(wordsize)
    local status = {} -- array to hold guess status, initilay empty
    local score = check_word(guess, wordsize, status, choice)
    io.write("Guess :", i, ' ')
    print_word(guess, wordsize, status)
    -- if the user find the entire word 
    if score == (wordsize * EXACT) then won = true break end
  end

  if won == true then
    io.write(GREEN,"You won !", RESET, '\n')
  else
    io.write(RED, "Game over! X( ", RESET, "the word to find was ", GREEN, string.format("%s", choice), RESET, '\n')
  end
end


function get_guess(worsize)
  local guess
  repeat
    io.write(string.format("Input a %i letter word: ", worsize))
    guess = io.read()
  until #guess == worsize
    return string.lower(guess)
end

function check_word(guess, wordsize, status, choice)
  local score = 0
  for i=1, wordsize do
    local x = guess:sub(i,i)
    local match = string.find(choice, x)
    if match then
      if match == i then
        status[i] = EXACT
        score = score + EXACT
      elseif match ~= i then
        status[i] = CLOSE
        score = score + CLOSE
      end
    else status[i] = WRONG
    end
  end
  return score
end

function print_word(guess, wordsize, status)
  for i=1, wordsize do
    if status[i] == EXACT then
      io.write(GREEN, guess:sub(i,i), RESET)
    elseif status[i] == CLOSE then
      io.write(YELLOW, guess:sub(i,i), RESET)
    elseif status[i] == WRONG then
      io.write(RED, guess:sub(i,i), RESET)
    end
  end
  print("\n")
end

main()
