--https://cs50.harvard.edu/x/2023/psets/2/readability/

local function main()
  io.write("Text :")
  local text = io.read()
  -- count the number of words,letters and sentences in the text 
  local num_sentences, num_words, num_letters = count(text)

  local grade = calculate_score(num_sentences, num_words, num_letters)
  if grade > 16 then
    print("Grade 16+")
  elseif grade < 1 then
    print("Before Grade 1")
  else
    print("Grade", grade)
  end

end

function is_space(char)
  return char:match("%s") ~= nil
end

function isalnum(char)
  return char:match("%w") ~= nil
end

function count(text)
  local num_words = 1; -- i'm reading spaces to count words so the last word won't be counted
  local num_letters = 0;
  local num_sentences = 0;

  for i=1, #text do
    local c = text:sub(i,i)
    if isalnum(c) then
      num_letters = num_letters + 1;
    elseif is_space(c) then
      num_words = num_words + 1;
    elseif c == "." or c == "!" or c == "?" then
      num_sentences = num_sentences + 1;
    end
  end
  return num_sentences, num_words ,num_letters
end

function calculate_score(num_sentences, num_words, num_letters)
  local L = (num_letters / num_words) * 100 -- avg of letters/100 words 
  local S = (num_sentences / num_words) * 100 -- avg sentences/100 words
  local grade = 0.0588 * L - 0.296 * S - 15.8
  if (grade - math.floor(grade)) > 0.5 then grade = math.ceil(grade) else grade = math.floor(grade) end
  return grade
end

main()
