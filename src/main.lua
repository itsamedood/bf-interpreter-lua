-- Import interpreter module.
package.path = "src/?.lua;" .. package.path
local interpreter = require "interpreter"

io.write("Code: ")
local code = io.read()

if type(code) == "string" then interpreter.interpret(code) end
