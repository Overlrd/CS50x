-- https://cs50.harvard.edu/x/2023/psets/1/credit/

local cards_info = {AMEX = {34,37} ; MASTERCARD = {51, 52, 53, 54, 55} ; VISA = {4}}

function main()
    local card_number = nil;
    repeat
        io.write("Number: ")
        card_number = io.read("*n")
        io.read()
    until type(card_number) == "number"

    card_number = tostring(card_number)
    if string.len(card_number) ~= 13 and string.len(card_number) ~= 15 and string.len(card_number) ~= 16 then
      print("INVALID")
      return 0
    end

    if luhn(card_number) then
      card_povider = get_card_provider(card_number)
    end
    print(card_povider)
end


function luhn(card_number)
  local is_valid = false;
  local first_sum_str = "";
  local first_sum = 0;
  local second_sum =0;
  local hash = 0;
  card_number = string.reverse(card_number)

  -- multiply every other digit by 2 starting with the number's second to last digit 
  -- and add them together

  for i=1, #card_number do
    if i % 2 == 0 then
      first_sum_str = first_sum_str .. (card_number:sub(i,i) * 2)
    else
      second_sum = second_sum + tonumber(card_number:sub(i,i))
    end
  end

  for i=1, #first_sum_str do
    first_sum = first_sum + first_sum_str:sub(i,i)
  end

  hash = first_sum + second_sum
  if hash % 10 == 0 then is_valid = true end

  return is_valid
end


function get_card_provider(card_number)
  local card_povider = "INVALID";
  for k in pairs(cards_info) do
    for key, value in ipairs(cards_info[k]) do
      if string.starts(card_number, tostring(value)) then
        card_povider = k
      end
    end
  end
  return card_povider
end


-- https://stackoverflow.com/questions/22831701/lua-read-beginning-of-a-string
function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end


main()
