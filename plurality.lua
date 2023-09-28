#!/usr/bin/lua
MAX = 9 -- maximum number of candidates

Candidate = {}
function Candidate.new(name, votes)
  return {name = name, votes = votes}
end

function main()
  local candidates = get_candidates()
  _G.CANDIDATES = candidates

  io.write("Number of voters: ")
  local num_votes = tonumber(io.read())

  for i=1, num_votes do
    io.write("Vote: ")
    local name = io.read()
    if not vote(name) then
      print("Invalid vote")
    end
  end

  print_winner()
end

function print_winner()
  local winners = {}
  -- bubble sort candidates based on num votes
  for _, candidate in ipairs(_G.CANDIDATES) do
    if _G.CANDIDATES[_+1] ~= nil then
      if candidate.votes > _G.CANDIDATES[_+1].votes then
        local tmp_name = candidate.name
        local tmp_votes = candidate.votes
        candidate.name = _G.CANDIDATES[_+1].name
        candidate.votes = _G.CANDIDATES[_+1].votes
        _G.CANDIDATES[_+1].name = tmp_name
        _G.CANDIDATES[_+1].votes = tmp_votes
      end
    end
  end
  for _, candidate in ipairs(_G.CANDIDATES) do
    print(candidate.name)
  end
end

function vote(name)
  for _, candidate in ipairs(_G.CANDIDATES) do
      if candidate.name == name then
        candidate.votes = candidate.votes + 1
        return true
      end
  end
  return false
end

function get_candidates()
   -- check args
  local candidates = {} -- array of candidates
  if #arg < 2 then
    print("Usage : ./plurality.lua [CANDIDATE ...]")
    return
  elseif #arg > MAX then
    print("Maximun number of candidates is %s", MAX)
    return
  end
  for i=1, #arg do
    candidates[i] = Candidate.new(arg[i], 0)
  end
  return candidates
end

main()
