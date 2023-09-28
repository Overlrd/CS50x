#!/usr/bin/lua

local function main()
  if #arg ~= 1 then print("Usage ./subsitution.lua KEY ") return end
  local key = check_key(arg[1])
  if not key then print("Each letter of the key must be unique ") return end

  io.write("plaintext: ")
  local plaintext = io.read()

  local ciphertext = get_cipher(plaintext, key)
  io.write("ciphertext: ", ciphertext, "\n")
end


function check_key (key)
  assert(#key == 26, "The Key must be 26 characters long ")
  local set = {}
  for i=1, #key do
    local char = key:sub(i,i)
    if set[char] then return false else set[char] = true end
  end
  return key
end

function get_cipher(text, cipher_key)
  local byte_a = 97
  local byte_A = 65
  local cipher_text = ""
  for i=1, #text do
    local char = text:sub(i, i)
    if char:match("%w") ~= nil then
      if string.byte(char) >= byte_a then
        local x = (string.byte(char) - byte_a) + 1
        cipher_text = cipher_text .. string.lower(cipher_key:sub(x, x))
      else
        local x = (string.byte(char) - byte_A) + 1
        cipher_text = cipher_text .. string.upper(cipher_key:sub(x, x))
      end
    else
      cipher_text = cipher_text .. char
    end
  end
  return cipher_text
end

main()
