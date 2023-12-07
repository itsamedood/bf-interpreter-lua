local interpreter = {}

--- Splits a string into individual characters.
--- @param string string
--- @return table
local function split(string)
  local characters = {}

  for i=1, #string do
    local char = string:sub(i, i)
    table.insert(characters, char)
  end

  return characters
end

--- Interprets given Brainf**k code.
--- @param _code string
function interpreter.interpret(_code)
  local ITER_LIMIT = 10000

  local code = split(_code)
  local data = {0}
  local pointer = 1 -- Lua indexes start at 1 instead of 0.
  local loopstart = 1
  local i = 1
  local j = 1

  while i <= #code and j < ITER_LIMIT do
    local char = code[i]

    if type(char) == "string" then
      if char == "+" then data[pointer] = data[pointer] + 1
      elseif char == "-" then data[pointer] = data[pointer] - 1
      elseif char == ">" then pointer = pointer + 1; if pointer > #data then data[pointer] = 0 end
      elseif char == "<" then if pointer > 1 then pointer = pointer - 1 end
      elseif char == "." then print(string.char(data[pointer])) -- Print out ASCII value of number (ex. 72 -> 'H').
      elseif char == "," then
        while true do
          io.write("Enter a number: ")
          local numinput = io.read()

          -- Attempt to convert `num` to a number, but `nil` if not a number.
          local num = tonumber(numinput)
          if num then data[pointer] = num; break end
        end
      elseif char == "[" then loopstart = i
      elseif char == "]" then if data[pointer] == 0 then else i = loopstart end
      end

      i = i + 1
      j = j + 1
    end
  end

  if j == ITER_LIMIT then print("Reached max iter limit.") end

  print("Data: ", table.concat(data, ", "))
  print(string.format("Pointer: %i", pointer))
end

return interpreter
