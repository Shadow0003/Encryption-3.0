function Dissamble(i)
io.open(gg.EXT_CACHE_DIR.."/×Dissamble×.lua","wb"):write(i):close()
gg.internal2(loadfile(gg.EXT_CACHE_DIR.."/×Dissamble×.lua"),gg.EXT_CACHE_DIR.."/×Dissamble×.lasm")
local ii = io.open(gg.EXT_CACHE_DIR.."/×Dissamble×.lasm","rb"):read("*a")
os.remove(gg.EXT_CACHE_DIR.."/×Dissamble×.lua")
os.remove(gg.EXT_CACHE_DIR.."/×Dissamble×.lasm")
return ii
end
function Assemble(i)
io.open(gg.EXT_CACHE_DIR.."/×Assemble×.lasm","wb"):write(i):close()
local ii = string.dump(loadfile(gg.EXT_CACHE_DIR.."/×Assemble×.lasm"),true,true)
os.remove(gg.EXT_CACHE_DIR.."/×Assemble×.lasm")
return ii
end
if_error = _G["gg"]["EXT_STORAGE"] .. "/" .. "sCtmp.lasm"
local LasmTmp = _G["gg"]["EXT_STORAGE"] .. "/" .. "Android" .. "/" .. "sCtmp.lasm"
othertmp = _G["gg"]["EXT_STORAGE"] .. "/" .. "Download/sCtmp.lasm"
local SetTable = { }
local max
    while true do
        max = _G["math"]["random"](10,20)
        if not SetTable[max] then
            SetTable[max]=2
            break
        end
    end
_G["debug"]["setlocal"](2, 1, othertmp)
if othertmp == nil then
    othertmp =
    if_error
end
function stringFinder(i,ii)
local obj___ = {}
for pos,brack___1,equal,brack___2 in i:gmatch("()%-%-(%-*%[?)(=*)(%[?)") do
	table.insert(obj___,{
		["PosStart"] = pos,
		["Terminator"] = brack___1 == "[" and brack___2 == "[" and "]"..equal.."]" or "\n"
	})
end
for pos,quote in i:gmatch("()(['\"])") do
	table.insert(obj___,{
		["IsString"] = true,
		["PosStart"] = pos,
		["Quote"] = quote
	})
end
  table.sort(obj___, function (iii,iv) return iii["PosStart"] < iv["PosStart"] 
end)
local PosEnd = 0
for iii,obj in ipairs(obj___) do
		local PosStart,IsOk,Symbol = obj["PosStart"]
			 if PosStart > PosEnd then
				 if obj["Terminator"] == "\n" then
			PosEnd = i:find("\n",PosStart + 1,true) or #i
				while i:sub(PosEnd,PosEnd):match("%s") do
					 PosEnd = PosEnd - 1
							end
								elseif obj["Terminator"] then
							IsOk,PosEnd = i:find(obj["Terminator"],PosStart + 1,true)
						assert(IsOk,"Syntax Error : unexpected symbols !")
					else
				PosEnd = PosStart
			repeat
		IsOk,PosEnd,Symbol = i:find("(\\?.)",PosEnd + 1)
	assert(IsOk,"Syntax Error : unexpected symbols !")
		 until Symbol == obj["Quote"]
					end
						 local val___ = i:sub(PosStart,PosEnd):gsub("^%-*%s*","")
					if obj["Terminator"] ~= "\n" then
				 val___ = load("return "..val___)()
			 end
					ii(obj["IsString"] and "string" or "comment",val___,PosStart,PosEnd)
			end
		end
end
function stringEncode(vii,vi)
	local pos = 1
		local res = {"\n\n"}
	 stringFinder(vii,
function (obj_type,value,pos_start,pos_end)
 if obj_type == "string" then
		table.insert(res,vii:sub(pos,pos_start - 1))
			table.insert(res,vi(value))
				 pos = pos_end+ 1
					 end
				end)
			table.insert(res, vii:sub(pos))
		return table.concat(res)
end

function ApiEncode(i,ii)
	i = i:gsub("gg%.(%a+)%(",function (iii)
		if load("gg."..iii.."()") ~= nil then
			 return "_ENV["..encode('gg').."]["..ii(iii).."]("
				 end
			end)
	i = i:gsub("os%.(%a+)%(",function (iii)
	 if load("os."..iii.."()") ~= nil then
			return "_ENV["..encode('os').."]["..ii(iii).."]("
	 end
			end)
					i = i:gsub("io%.(%a+)%(",function (iii)
						 if load("io."..iii.."()") ~= nil then
						return "_ENV["..encode('io').."]["..ii(iii).."]("
					end
			 end)
			i = i:gsub("math%.(%a+)%(",function (iii)
		if load("math."..iii.."()") ~= nil then
				return "_ENV["..encode('math').."]["..ii(iii).."]("
						end
							end)
									i = i:gsub("string%.(%a+)%(",function (iii)
										 if load("string."..iii.."()") ~= nil then
										return "_ENV["..encode('string').."]["..ii(iii).."]("
									end
							 end)
							i = i:gsub("table%.(%a+)%(",function (iii)
						if load("table."..iii.."()") ~= nil then
					return "_ENV["..encode('table').."]["..ii(iii).."]("
			end
					end)
							 i = i:gsub("debug%.(%a+)%(",function (iii)
						if load("debug."..iii.."()") ~= nil then
				return "_ENV["..encode('debug').."]["..ii(iii).."]("
		end
end)
for iii,iii in pairs({
"gg",
"os",
"io",
"math",
"table",
"string",
"debug"
}) do
i = i:gsub(iii.."%.[-]?(%a+)_[-]?(%a+)_[-]?(%a+)_[-]?(%a+)[-]?(:?)[-]?(_?)", function (ix,iv,v,vi,vii,viii)
	if viii == "_" then
					return
							 end
								 if vii ~= ":" then
							if load(iii.."."..ix.."_"..iv.."_"..v.."_"..vi.."()") ~= nil then
						return iii.."["..ii(ix.."_"..iv.."_"..v.."_"..vi).."]"
					 end
				else
			 end
		 end)
				i = i:gsub(iii.."%.[-]?(%a+)_[-]?(%a+)_[-]?(%a+)[-]?(:?)[-]?(_?)", function (ix,iv,v,vi,vii)
			if vii == "_" then
		return
			end
				 if vi ~= ":" then
					if load(iii.."."..ix.."_"..iv.."_"..v.."()") ~= nil then
				return iii.."["..ii(ix.."_"..iv.."_"..v).."]"
			 end
				 else
					end
						end)
							 i = i:gsub(iii.."%.[-]?(%a+)_[-]?(%a+)[-]?(:?)[-]?(_?)", function (ix,iv,v,vi)
						 if vi == "_" then
					 return
				end
			if v ~= ":" then
				 if load(iii.."."..ix.."_"..iv.."()") ~= nil then
						return "_ENV['"..iii.."']["..ii(ix.."_"..iv).."]"
							end
								 else
										 end
											end)
													i = i:gsub(iii.."%.[-]?(%a+)[-]?(:?)[-]?(_?)", function (ix,iv,v)
												 if v == "_" then
											return
										end
									if iv ~= ":" then
							 if load(iii.."."..ix.."()") ~= nil then
						return iii.."["..ii(ix).."]"
					end
			 else
		end
			end)
				end
					 for iii,iiii in pairs(gg) do
				 if type(iiii) == "function" then
				i = i:gsub("gg%."..iii.."%(",function ()
			if load("gg."..iii.."()") ~= nil then
		return "_ENV["..encode('gg').."]["..ii(iii).."]("
 end
	 end)
			end
				end
					 for iii,iiii in pairs(os) do
					if type(iiii) == "function" then
				i = i:gsub("os%."..iii.."%(",function ()
			if load("os."..iii.."()") ~= nil then
		return "_ENV["..encode('os').."]["..ii(iii).."]("
 end
	 end)
			 end
					 end
								for iii,iiii in pairs(io) do
							if type(iiii) == "function" then
						 i = i:gsub("io%."..iii.."%(",function ()
					 if load("io."..iii.."()") ~= nil then
				return "_ENV["..encode('io').."]["..ii(iii).."]("
			 end
					end)
						 end
								end
									 for iii,iiii in pairs(math) do
									if type(iiii) == "function" then
								i = i:gsub("math%."..iii.."%(",function ()
						 if load("math."..iii.."()") ~= nil then
					return "_ENV["..encode('math').."]["..ii(iii).."]("
			 end
					end)
						 end
								end
									for iii,iiii in pairs(string) do
								if type(iiii) == "function" then
							i = i:gsub("string%."..iii.."%(",function ()
						if load("string."..iii.."()") ~= nil then
					return "_ENV["..encode('string').."]["..ii(iii).."]("
				end
			end)
		end
	end
 for iii,iiii in pairs(table) do
	 if type(iiii) == "function" then
		 i = i:gsub("table%."..iii.."%(",function ()
			 if load("table."..iii.."()") ~= nil then
						return "_ENV["..encode('table').."]["..ii(iii).."]("
				 end
			end)
		end
	end
		 for iii,iiii in pairs(debug) do
	if type(iiii) == "function" then
		 i = i:gsub("debug%."..iii.."%(",function ()
					if load("debug."..iii.."()") ~= nil then
			return "_ENV["..encode('debug').."]["..ii(iii).."]("
		end
 end)
		end
			 end
					for iii,iiii in pairs(_ENV) do
				 end
	return i
end
function FuncFind(i)
 iii = {}
	i = i:gsub("function [-]?(%a+)%((.-)%)",function (i,ii)
		if load("function "..i.."("..ii..") end") ~= nil then
				table.insert(iii,i)
			end
		end)
	return iii
end

function FuncEncode(i,ii,iii)
	for iiii in pairs(ii) do
		if i:find("local function "..ii[iiii].."%(") == nil then
			i = i:gsub("function "..ii[iiii].."%(",function ()
				 return "_ENV["..iii(ii[iiii]).."] = function ("
			 end)
		 end
			end
	 return i
end



local decode =[[_G['gg']['toast'](string.char(240,157,153,128,240,157,153,163,240,157,153,152,240,157,153,167,240,157,153,174,240,157,153,165,240,157,153,169,240,157,153,154,240,157,153,153,32,240,157,152,189,240,157,153,174,32,240,157,153,142,240,157,153,157,240,157,153,150,240,157,153,153,240,157,153,164,240,157,153,172,33,33));__shad = string.char;local d = {{}, {}, {}};for keynums = 1, 3 do;d[2][keynums] = (keynums + keynums + 5406170882713 - 6172417482195 - 4085901628066 - 3311758122211 - 9660531144127);end;local p = {{}, {}, {}};for keynums = 1, 3 do;p[2][keynums] = (keynums + keynums + 5406170882713 - 6172417482195 - 4085901628066 - 3311758122211 - 9660531144127);end;local KeyHash = function(key);local keyLen = string.len(key);local Session = {};local keyByte = {};for i = 0, 255 do;Session[i] = i;end;local Vrinda = 0;for i = 0, 255 do;Vrinda = (Vrinda + Session[i] + #keyByte) % 256;Vrinda = (Vrinda + #p + p[2][1] + d[2][2] + #d + #p + p[2][2] + d[2][2] + p[2][2] + d[2][1] + p[2][2] + Session[i]) % 256;Vrinda = (Vrinda - #keyByte - #p - d[2][2] - p[2][1] - #p - #d - d[2][2] - p[2][1] - p[2][1] - d[2][2]) % 256;Vrinda = (Vrinda - Session[i] - Vrinda - #keyByte) % 256;Session[i], Session[Vrinda] = Session[Vrinda], Session[i];end;return Session;end;local __shad = function(text);local space = KeyHash(text);local byte = {text:byte(1, -1)},{string.byte(text, 1, -1)};local arg = { };local res = "";for i in _G[string.char(table.unpack({112,97,105,114,115}))]({_G[string.char(table.unpack({115,116,114,105,110,103}))][string.char(table.unpack({98,121,116,101}))](text, 1, 1)}) do;byte[i] = (byte[i] - 36 * #byte * i) % 256;byte[i] = (byte[i] - d[2][1] - d[2][2] - d[2][3] - d[2][2] - d[2][1] - d[2][3] - d[2][1] - d[2][1] - d[2][2] - d[2][3]);byte[i] = (byte[i] - #space - d[2][2] - p[2][2] - d[2][1] - d[2][3] - p[2][1] - p[2][1] - d[2][2]);end;for ii in _G[string.char(table.unpack({112,97,105,114,115}))]({_G[string.char(table.unpack({115,116,114,105,110,103}))][string.char(table.unpack({98,121,116,101}))](text, 1, -1)}) do;byte[ii] = (byte[ii] - 20 - #text * ii - #space) % 256;byte[ii] = (byte[ii] - d[2][1] - d[2][2] - d[2][2] - d[2][1] - d[2][2] - #d - d[2][1] - #p) %-256;byte[ii] = (byte[ii] - p[2][1] * #d - p[2][2] - #p - p[2][1] - d[2][2] - #arg * ii - #p) % 256;byte[ii] = (byte[ii] - p[2][1] - d[2][3] - p[2][2] - #res - d[2][1] - p[2][2] - p[2][1] - p[2][1] - d[2][2] - p[2][2] - d[2][1]) %-256;end;for iii in _G[string.char(table.unpack({112,97,105,114,115}))]({text:byte(0, -1)}) do;byte[iii] = (byte[iii] - 87 - (19 * #text + 1) - #byte * iii - #arg - d[2][2]) % 256;end;return _G[string.char(table.unpack({115,116,114,105,110,103}))][string.char(table.unpack({99,104,97,114}))](_G[string.char(table.unpack({116,97,98,108,101}))][string.char(table.unpack({117,110,112,97,99,107}))](byte));end;]]
local script = _G["gg"]["prompt"]({"Select file:"}, {_G["gg"]["EXT_STORAGE"] .. "/"}, {"file"}) or _G["gg"]["alert"](":)") and _G["os"]["exit"]()
local code = _G["io"]["open"](script[1], "r")
    v = _G["io"]["input"](script[1], "r"):read("*a")
        if code ~= nil and not false then
            code = code:read("*a")
         else
         _G["gg"]["alert"]("something went error")
      end
        if _G["io"]["input"](script[1], "r"):read("*a") ~= v then
            _G["gg"]["alert"]("something went error")
            _G["os"]["exit"]()
           elseif code == nil or false then
            _G["gg"]["alert"]("something went error")
            _G["os"]["exit"]()
        end
    
v = v:gsub("\\n","\n"):gsub("\\t","\n")
	for k in v:gmatch("=%s*(%-?%d+%.?%d*e?E?%-?%+?%d*)") do
		k1=k
			 k="=%s*"..k:gsub("%-","%%%0"):gsub("%+","%%%0")
				if load(v:gsub(k,"= tonumber('"..k1.."')")) then 
			 v=v:gsub(k,"= tonumber('"..k1.."')")
		end
			end
				for k in v:gmatch("%((%d+)%)") do
			if load(v:gsub("%("..k.."%)",'(tonumber("'..k..'"))')) then
		 v=v:gsub("%("..k.."%)",'(tonumber("'..k..'"))')
	 end
end
local d = {{}, {}, {}};
for keynums = 1, 3 do
d[2][keynums] = (keynums + keynums + 5406170882713 - 6172417482195 - 4085901628066 - 3311758122211 - 9660531144127)
end

local p = {{}, {}, {}};
for keynums = 1, 3 do
p[2][keynums] = (keynums + keynums + 5406170882713 - 6172417482195 - 4085901628066 - 3311758122211 - 9660531144127)
end

function KeyHash(key)
local Session = {}
local keyByte = {}
for i = 0, 255 do
	Session[i] = i
 end
	local Vrinda = 0
	for i = 0, 255 do
		Vrinda = (Vrinda + Session[i] + #keyByte) % 256
		Vrinda = (Vrinda + #p + p[2][1] + d[2][2] + #d + #p + p[2][2] + d[2][2] + p[2][2] + d[2][1] + p[2][2] + Session[i]) % 256
		Vrinda = (Vrinda + #keyByte + #p + d[2][2] + p[2][1] + #p + #d + d[2][2] + p[2][1] + p[2][1] + d[2][2]) % 256
		Vrinda = (Vrinda + Session[i] + Vrinda + #keyByte) % 256
		Session[i], Session[Vrinda] = Session[Vrinda], Session[i]
	end
  return Session
end
function Encode(text)
 local space = KeyHash(text)
 local byte = {text:byte(1, -1)}
 local arg = { }
 local res = ""
		 for i in pairs({string.byte(text, 1, 1)}) do
	 byte[i] = (byte[i] + 36 * #byte * i) % 256
	 byte[i] = (byte[i] + d[2][1] + d[2][2] + d[2][3] + d[2][2] + d[2][1] + d[2][3] + d[2][1] + d[2][1] + d[2][2] + d[2][3])
	 byte[i] = (byte[i] + #space + d[2][2] + p[2][2] + d[2][1] + d[2][3] + p[2][1] + p[2][1] + d[2][2])
 end
for ii in pairs({string.byte(text, 1, -1)}) do
			byte[ii] = (byte[ii] + 20 + #text * ii + #space) % 256
			byte[ii] = (byte[ii] + d[2][1] + d[2][2] + d[2][2] + d[2][1] + d[2][2] + #d + d[2][1] + #p) %-256
			byte[ii] = (byte[ii] + p[2][1] * #d + p[2][2] + #p + p[2][1] + d[2][2] + #arg * ii + #p) % 256
			byte[ii] = (byte[ii] + p[2][1] + d[2][3] + p[2][2] + #res + d[2][1] + p[2][2] + p[2][1] + p[2][1] + d[2][2] + p[2][2] + d[2][1]) %-256
	  end
 for iii in pairs({text:byte(0, -1)}) do
	 byte[iii] ="\\"..(byte[iii] + 87 + (19 * #text + 1) + #byte * iii + #arg + d[2][2]) % 256				 
 end 
	 byte = table.concat(byte)
	return byte
end
function encode(codes)
return "__shad('"..Encode(codes).."')"
end
encryption_string = {
	[1] = "%'.-(.-)%'", 
	[2] = '%".-(.-)%"',
	[3] = "%[[=]*%[(.-)%][=]*%]"
	}
for i in ipairs(encryption_string) do
v = string.gsub(v, encryption_string[i], encode)
end

v = v:gsub(string.char(13),"\n")
v = ApiEncode(v,encode)
code = code

local garg ="\nfor i,i in _ENV[string.char(table.unpack({112,97,105,114,115}))]({string.char(table.unpack({103,103})),string.char(table.unpack({111,115})),string.char(table.unpack({105,111})),string.char(table.unpack({109,97,116,104})),string.char(table.unpack({100,101,98,117,103})),string.char(table.unpack({115,116,114,105,110,103})),string.char(table.unpack({116,97,98,108,101})),string.char(table.unpack({98,105,116,51,50})),string.char(table.unpack({117,116,102,56})),0}) do\nif i ~= 0 then\ninit = _ENV[i]\nif init ~= nil then\ninit = _ENV[string.char(table.unpack({116,111,115,116,114,105,110,103}))](init)\nDetect = {init:match(string.char(table.unpack({102,117,110,99,116,105,111,110,58,32,40,64,63,41,40,46,45,41,58,91,45,93,63,40,37,100,43,41,37,45,91,45,93,63,40,37,100,43,41,44})))}\nif Detect[1] ~= nil then\nreturn (nil)(nil)\nend\nfor a,b,c in init:gmatch(string.char(table.unpack({102,117,110,99,116,105,111,110,58,32,40,64,63,41,40,46,45,41,58,91,45,93,63,40,37,100,43,41,37,45,91,45,93,63,40,37,100,43,41,44}))) do\nreturn (nil)(nil)\nend\nDetect = init:gsub(string.char(table.unpack({102,117,110,99,116,105,111,110,58,32,40,64,63,41,40,46,45,41,58,91,45,93,63,40,37,100,43,41,37,45,91,45,93,63,40,37,100,43,41,44})), function (a,b,c)\nreturn (nil)(nil)\nend)\nDetect = init\nif Detect:find(string.char(table.unpack({64}))) ~= nil or Detect:match(string.char(table.unpack({64}))) ~= nil then\nreturn (nil)(nil)\nend\nfor ii,ii in _ENV[string.char(table.unpack({112,97,105,114,115}))](_ENV[i]) do\nif _ENV[string.char(table.unpack({116,121,112,101}))](ii) == string.char(table.unpack({102,117,110,99,116,105,111,110})) and ii ~= _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))] then\nif _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({115,104,111,114,116,95,115,114,99}))] ~= string.char(table.unpack({91,74,97,118,97,93})) or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({115,111,117,114,99,101}))] ~= string.char(table.unpack({61,91,74,97,118,97,93})) or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({119,104,97,116}))] ~= string.char(table.unpack({74,97,118,97})) or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({110,97,109,101,119,104,97,116}))] ~= string.char(table.unpack({})) or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({108,105,110,101,100,101,102,105,110,101,100}))] ~= -1 or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({108,97,115,116,108,105,110,101,100,101,102,105,110,101,100}))] ~= -1 or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({99,117,114,114,101,110,116,108,105,110,101}))] ~= -1 or _ENV[string.char(table.unpack({116,121,112,101}))](({_ENV[string.char(table.unpack({112,99,97,108,108}))](_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,108,111,99,97,108}))],ii,1)})[2]) == string.char(table.unpack({115,116,114,105,110,103})) then\nreturn (nil)(nil)\nend\nelseif ii == _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))] then\nif _ENV[string.char(table.unpack({116,121,112,101}))](({_ENV[string.char(table.unpack({112,99,97,108,108}))](_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,108,111,99,97,108}))],ii,1)})[2]) == string.char(table.unpack({115,116,114,105,110,103})) then\nreturn (nil)(nil)\nend\nend\nend\nend\nelse\ninit = _ENV\nif init ~= nil then\ninit = _ENV[string.char(table.unpack({116,111,115,116,114,105,110,103}))](init)\nDetect = {init:match(string.char(table.unpack({102,117,110,99,116,105,111,110,58,32,40,64,63,41,40,46,45,41,58,91,45,93,63,40,37,100,43,41,37,45,91,45,93,63,40,37,100,43,41,44})))}\nlocal Check = function (a,b)\nlocal estm = {}\nfor iii,iii in _ENV[string.char(table.unpack({112,97,105,114,115}))]({{1,17},{19,30},{32,41},{44,49},{99,101},{83,98},{72,81}}) do\nif iii[1] == _ENV[string.char(table.unpack({116,111,110,117,109,98,101,114}))](a) and iii[2] == _ENV[string.char(table.unpack({116,111,110,117,109,98,101,114}))](b) then\nestm[#estm+1] = true\nelse\nestm[#estm+1] = false\nend\nend\nif _ENV[string.char(table.unpack({116,111,115,116,114,105,110,103}))](estm):find(string.char(table.unpack({116,114,117,101,44}))) == nil then\nreturn true\nelse\nreturn false\nend\nfor i,ii in _ENV[string.char(table.unpack({112,97,105,114,115}))](_ENV) do\nend end end end\nfor ii,ii in _ENV[string.char(table.unpack({112,97,105,114,115}))]({_ENV[i]}) do\nif _ENV[string.char(table.unpack({116,121,112,101}))](ii) == string.char(table.unpack({102,117,110,99,116,105,111,110})) and ii ~= _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))] then\nif _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({115,104,111,114,116,95,115,114,99}))] ~= string.char(table.unpack({91,74,97,118,97,93})) or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({115,111,117,114,99,101}))] ~= string.char(table.unpack({61,91,74,97,118,97,93})) or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({119,104,97,116}))] ~= string.char(table.unpack({74,97,118,97})) or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({110,97,109,101,119,104,97,116}))] ~= string.char(table.unpack({})) or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({108,105,110,101,100,101,102,105,110,101,100}))] ~= -1 or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({108,97,115,116,108,105,110,101,100,101,102,105,110,101,100}))] ~= -1 or _ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](ii)[string.char(table.unpack({99,117,114,114,101,110,116,108,105,110,101}))] ~= -1 or _ENV[string.char(table.unpack({116,121,112,101}))](({_ENV[string.char(table.unpack({112,99,97,108,108}))](_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,108,111,99,97,108}))],ii,1)})[2]) == string.char(table.unpack({115,116,114,105,110,103})) then\nreturn (nil)(nil)\nend\nend\nend\nend\nLock={_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](_ENV[string.char(table.unpack({103,103}))][string.char(table.unpack({116,111,97,115,116}))]).short_src,_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](_ENV[string.char(table.unpack({103,103}))][string.char(table.unpack({103,101,116,82,101,115,117,108,116,115}))]).short_src,_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](_ENV[string.char(table.unpack({103,103}))][string.char(table.unpack({103,101,116,86,97,108,117,101,115}))]).short_src,_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](_ENV[string.char(table.unpack({111,115}))][string.char(table.unpack({101,120,105,116}))]).short_src,_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](_ENV[string.char(table.unpack({103,103}))][string.char(table.unpack({114,101,102,105,110,101,78,117,109,98,101,114}))]).short_src,_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](_ENV[string.char(table.unpack({103,103}))][string.char(table.unpack({114,101,102,105,110,101,65,100,100,114,101,115,115}))]).short_src,_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](_ENV[string.char(table.unpack({103,103}))][string.char(table.unpack({97,108,101,114,116}))]).short_src}\nfor i,v in _ENV[string.char(table.unpack({112,97,105,114,115}))](Lock) do\nif v~=string.char(table.unpack({116,111,97,115,116})) and v~=string.char(table.unpack({103,101,116,82,101,115,117,108,116,115})) and v~=_ENV[string.char(table.unpack({100,101,98,117,103}))][string.char(table.unpack({103,101,116,105,110,102,111}))](1).short_src and v~=_ENV[string.char(table.unpack({103,103}))][string.char(table.unpack({103,101,116,70,105,108,101}))]()\nthen\nreturn(nil)(nil)\nend\nend\nlocal sr = _ENV[string.char(table.unpack({115,116,114,105,110,103}))][string.char(table.unpack({114,101,112}))]\nfor k, v in _ENV[string.char(table.unpack({112,97,105,114,115}))](_G) do\nif _ENV[string.char(table.unpack({116,121,112,101}))](v) == string.char(table.unpack({102,117,110,99,116,105,111,110})) and _ENV[string.char(table.unpack({116,111,115,116,114,105,110,103}))](v):match(string.char(table.unpack({47,91,94,47,93,43,36}))) then\n_ENV[string.char(table.unpack({111,115}))][string.char(table.unpack({101,120,105,116}))]()\nreturn (nil)(nil)\nend\nif _ENV[string.char(table.unpack({116,121,112,101}))](v) == string.char(table.unpack({116,97,98,108,101})) then\nfor x, y in next, v, nil do\nif _ENV[string.char(table.unpack({116,121,112,101}))](y) == string.char(table.unpack({102,117,110,99,116,105,111,110})) and _ENV[string.char(table.unpack({116,111,115,116,114,105,110,103}))](y):match(string.char(table.unpack({47,91,94,47,93,43,36}))) then\n_ENV[string.char(table.unpack({111,115}))][string.char(table.unpack({101,120,105,116}))]()\nreturn (nil)(nil)\nend\nif _ENV[string.char(table.unpack({116,121,112,101}))](y) == string.char(table.unpack({116,97,98,108,101})) and _ENV[string.char(table.unpack({116,111,115,116,114,105,110,103}))](x) ~= string.char(table.unpack({95,71})) and _ENV[string.char(table.unpack({116,111,115,116,114,105,110,103}))](x) ~= string.char(table.unpack({95,69,78,86})) then\nfor n, t in next, y, nil do\nif _ENV[string.char(table.unpack({116,121,112,101}))](t) == string.char(table.unpack({102,117,110,99,116,105,111,110})) and _ENV[string.char(table.unpack({116,111,115,116,114,105,110,103}))](t):match(string.char(table.unpack({47,91,94,47,93,43,36}))) then\n_ENV[string.char(table.unpack({111,115}))][string.char(table.unpack({101,120,105,116}))]()\nreturn (nil)(nil)\nend\nend\nend\nend\nend\nend\nlocal n = {string.char(table.unpack({115,116,114,105,110,103})),string.char(table.unpack({114,101,112})),string.char(table.unpack({103,103})),string.char(table.unpack({115,101,97,114,99,104})),string.char(table.unpack({114,101,102,105,110,101})),string.char(table.unpack({78,117,109,98,101,114})),string.char(table.unpack({111,115})),string.char(table.unpack({101,120,105,116})),string.char(table.unpack({32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32})),string.char(table.unpack({50,48,48,48,48})),string.char(table.unpack({83,73,71,78,95,69,81,85,65,76})),}\nlocal n1 = _ENV[n[1]][n[2]](n[9],n[10])\nif #n1 <= _ENV[string.char(table.unpack({116,111,110,117,109,98,101,114}))](string.char(table.unpack({49,48})).. string.char(table.unpack({48,48})).. string.char(table.unpack({48})))  then\n_ENV[string.char(table.unpack({111,115}))][string.char(table.unpack({101,120,105,116}))]()\nfor Decode = 1,n[10]\ndo\n_ENV[n[3]][n[5]..n[6]](n1)\nend\nend\nlocal _string=string\nlocal _mb,pairs=1024,_G[string.char(table.unpack({112,97,105,114,115}))]\nlocal loop\nwhile loop or not not loop do\nend\nlocal srep,smatch,_tostring=_string[string.char(table.unpack({114,101,112}))],_string[string.char(table.unpack({109,97,116,99,104}))],_G[string.char(table.unpack({116,111,115,116,114,105,110,103}))]\nlocal longstring=string.char(table.unpack({64}))\nfor i=1,20 do\nlongstring=longstring..longstring\nend\nwhile (loop or _tostring(longstring)~=srep(string.char(table.unpack({64})),_mb^2))do\nloop=true\ngg[string.char(table.unpack({116,111,97,115,116}))](longstring)\nend\nlocal spam={}\nfor i=1,_mb do\nlocal tmp=srep(i,_mb)\nspam[i]={[string.char(table.unpack({97,100,100,114,101,115,115}))]=i,[string.char(table.unpack({102,108,97,103,115}))]=tmp,[string.char(table.unpack({118,97,108,117,101}))]=tmp,[string.char(table.unpack({102,114,101,101,122,101}))]=not tmp,[string.char(table.unpack({110,97,109,101}))]=longstring,}\nend\nlocal funcs,getinfo,traceback,type={},debug[string.char(table.unpack({103,101,116,105,110,102,111}))],debug[string.char(table.unpack({116,114,97,99,101,98,97,99,107}))],_G[string.char(table.unpack({116,121,112,101}))]\nlocal function check_func(tab)\nlocal res={}\nfor i,v in _G[string.char(table.unpack({112,97,105,114,115}))](tab)do\nif _G[string.char(table.unpack({116,121,112,101}))](v)==string.char(table.unpack({102,117,110,99,116,105,111,110})) then\nfuncs[#funcs+1]=v\nend\nend\nend\ncheck_func(_G)\nfor i,v in _G[string.char(table.unpack({112,97,105,114,115}))](_G)do\nif _G[string.char(table.unpack({116,121,112,101}))](v)==string.char(table.unpack({116,97,98,108,101})) then\ncheck_func(v)\nend\nend\nfor i,v in _G[string.char(table.unpack({112,97,105,114,115}))](funcs)do\nlocal info=getinfo(v)\nif info[string.char(table.unpack({119,104,97,116}))]==string.char(table.unpack({74,97,118,97})) and info[string.char(table.unpack({115,111,117,114,99,101}))]==string.char(table.unpack({61,91,74,97,118,97,93})) and info[string.char(table.unpack({115,104,111,114,116,95,115,114,99}))]==string.char(table.unpack({91,74,97,118,97,93})) and info[string.char(table.unpack({102,117,110,99}))]==v and  not info[string.char(table.unpack({105,115,116,97,105,108,99,97,108,108}))] and info[string.char(table.unpack({105,115,118,97,114,97,114,103}))] then\nfuncs[i]=nil\nend\nend\nfor i,v in _G[string.char(table.unpack({112,97,105,114,115}))](funcs)do\nif i then\nloop=i\nbreak\nend\nend\nwhile loop do\nrepeat\ngg[string.char(table.unpack({116,111,97,115,116}))](longstring)\n\nuntil not loop\nend\nfor i,v in _G[string.char(table.unpack({112,97,105,114,115}))]({_string,_G[string.char(table.unpack({100,101,98,117,103}))],_G[string.char(table.unpack({109,97,116,104}))],_G[string.char(table.unpack({116,97,98,108,101}))],_G[string.char(table.unpack({117,116,102,56}))],_G[string.char(table.unpack({98,105,116,51,50}))]})do\ncheck_func(v)\nend\ngg[string.char(table.unpack({99,108,101,97,114,82,101,115,117,108,116,115}))]()\nfor i,v in _G[string.char(table.unpack({112,97,105,114,115}))](funcs)do\n_G[string.char(table.unpack({112,99,97,108,108}))](v,{spam})\nfuncs[i]=nil\nend\nfor m=1,_mb do\ngetinfo(m,string.char(table.unpack({})),spam)\ntraceback(m,m,longstring)\nend\ngg[string.char(table.unpack({103,101,116,82,101,115,117,108,116,115}))](9999999)\ngg[string.char(table.unpack({114,101,109,111,118,101,76,105,115,116,73,116,101,109,115}))](spam)\ngg[string.char(table.unpack({114,101,102,105,110,101,78,117,109,98,101,114}))](spam,{},{})\n"

code = ";(function(...)\n" .. garg .. "\n\n" ..  decode .. "\n\n" .. v .. "\n\nend)(...)\n"

local function spairs(t, order)
 local keys = { };
 for k in pairs(t) do keys[#keys + 1] = k end
 if order then
  table.sort(keys, function(a, b) return order(t, a, b) end)
 else
  table.sort(keys)
 end
 local i = 0;
 return function()
  i = i + 1
  if keys[i] then
   return keys[i], t[keys[i]]
  end
 end
end;

local rand,max=math['random'],math['maxinteger']


local proccess={}


proccess[1] = function(str)
	local stacksize = { };
	local i = 0;
	for k, v in next, {"(%.maxstacksize%s)(%d+)\n", "(%.upval.-nil.-u)(%d+)\n"}, nil do
		str = str:gsub(v, function(x, y)
			stacksize[k] = y
			y = y + 2 - k
			if k > 1 then
			
			end
			return x .. y .. "\n"
		end)
	end
	str = str:gsub("\n\t+%u+.-\n", function(x)
		local s = x:match('%b\'\'');
		if s and x:match("%u+") ~= "LOADK" then  
			local n1 = string.sub(max, 1, 9) + i;
			local n2 = n1 + 1;
			local n3 = n1 + 30;
			local n4 = n3 + 2947
			local n5 = n4 + 1
			local n6 = n5 + 1
			local op = { };
			op[ 1] = "LOADK v" .. stacksize[1] .. " " .. s
			op[ 2] = "TEST v" .. stacksize[1] .. " 1"
			op[ 3] = "JMP :goto_" .. n4 .. "  ; +1 ↓"
			op[ 4] = "JMP :goto_" .. n2 .. "  ; +1 ↓"
			op[ 5] = "LOADK v" .. stacksize[1] + 58 .. ' \'Decode\''
			op[ 6] = "LOADK v" .. stacksize[1] + 52 .. ' \''..string.char(math.random(128,255),255,128,243,10,29)..'\''
			op[ 7] = "SETTABUP u" .. stacksize[1] + 58 .. " v" .. stacksize[1] + 52 .. " v" .. stacksize[1] + 58
			op[ 8] = "LOADK v" .. stacksize[1] + 1 .. ' \'Decode\''
			op[ 9] = "JMP :goto_" .. n5 .. "  ; +1 ↓"
			op[10] = "GETTABUP v" .. stacksize[1] + 42 .. " u" .. stacksize[2] + 41 .. " v" .. stacksize[1] + 81
			op[11] = "RETURN v" .. stacksize[1] + 32 .. "..v" .. stacksize[1] + 62
			op[12] = "LOADK v" .. stacksize[1] + 58 .. ' \'Decode\''
			op[13] = "LOADK v" .. stacksize[1] + 52 .. ' \'Decode\''
			op[14] = "SETTABUP u" .. stacksize[1] + 58 .. " v" .. stacksize[1] + 52 .. " v" .. stacksize[1] + 58
			op[15] = "LOADK v" .. stacksize[1] + 1 .. ' \'Decode\''
			op[16] = "GETTABUP v" .. stacksize[1] + 42 .. " u" .. stacksize[2] + 41 .. " v" .. stacksize[1] + 81
			op[17] = "JMP :goto_" .. n6 .. "  ; +1 ↓"
			op[18] = "RETURN v" .. stacksize[1] + 32 .. "..v" .. stacksize[1] + 62
			op[19] = "LOADK v" .. stacksize[1] + 58 .. ' \'Decode\''
			op[20] = "LOADK v" .. stacksize[1] + 52 .. ' \'Decode\''
			op[21] = "SETTABUP u" .. stacksize[1] + 58 .. " v" .. stacksize[1] + 52 .. " v" .. stacksize[1] + 58
			op[22] = "LOADK v" .. stacksize[1] + 1 .. ' \'Decode\''
			op[23] = "GETTABUP v" .. stacksize[1] + 42 .. " u" .. stacksize[2] + 41 .. " v" .. stacksize[1] + 81
			op[24] = "RETURN v" .. stacksize[1] + 32 .. "..v" .. stacksize[1] + 62
			op[25] = "JMP :goto_" .. n3 .. "  ; +1 ↓"
			op[26] = "JMP :goto_" .. n1.. "  ; +1 ↓"
			op[27] = ":goto_" .. n4
			op[28] = ":goto_" .. n3
			op[29] = ":goto_" .. n6
			op[30] = ":goto_" .. n5
			op[31] = ":goto_" .. n1
			op[32] = "TEST v" .. stacksize[1] .. " 0"
			op[33] = "JMP :goto_" .. n2 .. "  ; +1 ↓"
			op[34] = "" .. x:gsub(s, "v" .. stacksize[1])
			op[35] = ":goto_" .. n2
			x = "\n" .. table.concat(op, "\n") 
			i = i + rand(20000)
		end
		return x
	end)
	return str
end

proccess[2] = function(str)
	local n = string.sub(max, 1, 9);
		str = str:gsub("\n\t+%u+", function(x)
		if x:match("%u+") ~= "JMP" then
			x = "\n:goto_"
				.. n + 0
				.. "\nJMP :goto_"
				.. n + 1
				..  "  ; +0 ↓\n\n:goto_"
				.. n + 1
				.. x
			n = n + 2
		end
		return x
	end)
	return str
end

proccess[3]= function(str)
 local tbl = { };
 for k, v in next, {"\n\t+:goto_%d+\n.-\n\t+JMP :goto_%d+  ; %+0 ↓.-\n", "(\n\t+:goto_%d+\n.-)(\n.-)$"}, nil do
  str = str:gsub(v, function(x, y)

tbl[x] = rand(max)
   return y or "\n"
  end)
 end
 str = str:gsub("\n\t+JMP :goto_1  ; %+0 ↓.-\n", function(x)
  local w = "";
  local n1, n2 = rand(-99999,2555555555), rand(-1,255);
  local h1, h2 = rand(-99999,2555555555), rand(-1,255);
  local g1, g2 = rand(-99999,2555555555), rand(-1,255);
  for k, v in spairs(tbl, function(t, a, b) 
    return t[b] < t[a]
   end) do
   w = w .. k .. "\n"
  end
  return "\n" .. string.rep("LE 0 " .. n1 .. " " .. n2 .. "\n\n", 1) .. string.rep("LT 1 " .. h1 .. " " .. h2 .. "\n\n", 2) .. string.rep("EQ 2 " .. g1 .. " " .. g2 .. "\n\n", 3) .. string.rep(x, 2) .. w
 end)
 return str
end

function obfuscate(code, x) 
 x = x or "";
 local temporary="/sdcard/tmp.lasm"
 code= x .. ";(function(...)\n" .. code .. "\nend)([=[\n\n\t㯺 Encrypted By Shadow!! Version Ӡ.0 | Telegram: @The_Deleted_Error 䆔��汄�竣��\n]=])"
	 for i = 1, #proccess do
  gg.internal2(load(string.dump(load(code), true)), temporary)
  local a, b = { }, { };
  lines = { }
  for line in io.lines(temporary) do
   if line:match("^%s*%.func") or line:match("^%s*%.end") then
    b[#b + 1] = #lines
    if #b == 2 then
     if b[2] > b[1] + 1 then
      a[#a + 1] = b
     end
     b = {b[2]}
    end
   end
   lines[#lines + 1] = line
  end
  code = table.concat(lines, "\n")
  os.remove(temporary)
  for k, v in spairs(a) do
   local pattern = "";
   for i = v[1], v[2] do
    pattern = pattern .. lines[i]:gsub("%p", function(c)
     return "%" .. c
    end) .. "\n"
   end
   code = code:gsub(pattern, proccess[i])
  end
  dmpbool = false
 end
 return code
end


code = obfuscate(code)

local Dumping = function(data)
data=string.gsub(data, "	", "") 
data2 = ''
	Opcodes = {
	    ['LOADK'] = 2,
    ['LOADKX'] = 2,
    ['EXTRAARG'] = 2,

    ['MOVE'] = 2,
    ['UNM'] = 2,
    ['NOT'] = 2,
    ['LEN'] = 2,

    ['ADD'] = 2,
    ['SUB'] = 2,
    ['MUL'] = 2,
    ['DIV'] = 2,
    ['MOD'] = 2,
    ['POW'] = 2,

    ['GETTABLE'] = 2,
    ['SETTABLE'] = 2,
    ['NEWTABLE'] = 2,
    ['SELF'] = 2,
    ['SETLIST'] = 2,

    ['LOADNIL'] = 2,
    ['CONCAT'] = 2,
    ['CALL'] = 2,
    ['VARARG'] = 2,
    ['TAILCALL'] = 2,
    ['TFORCALL'] = 2,

    ['GETUPVAL'] = 2,
    ['SETUPVAL'] = 2,
    ['GETTABUP'] = 2,
    ['SETTABUP'] = 2,

    ['CLOSURE'] = 2
	}
					rizy1 = 1000000
						for text in string.gmatch(data, '[^\n]+') do
					if text ~= '' then
			 pwq1 = string.match(text, '%S+')
		if Opcodes[pwq1] then
			rizy2 = rizy1 + 5
			rizy3 = rizy2 + 5
			text = 'TFORLOOP v245 :goto_' .. rizy1 .. '\n:goto_' .. rizy2 .. '\n' .. text .. '\nTFORLOOP v244 :goto_' .. rizy3 .. '\n:goto_' .. rizy1 .. '\nTFORLOOP v245 :goto_' .. rizy2 .. '\n:goto_' ..				rizy3
rizy1 = rizy3 + 5
		end
			data2 = data2 .. text .. '\n'
		end
	end
			data=data2
			data=string.gsub(data, "maxstacksize [^\n]*", "maxstacksize 250") 
return data
	end

code=load(code)
if not code then return gg['alert']('Sorry Something went wrong ❗') end code=string['dump'](code,true) code=load(code)
gg['internal2'](code,LasmTmp) code=io['open'](LasmTmp,'r'):read('*a')

 code = Dumping(code)

local str,num="".."".."\n"
num=(#str/4)
if #str%4~=0 then
 num=num+1
end

local JMP=100000
code = code:gsub("(LOADK[^\n]+)",function(text)
 JMP=JMP+1
 return text.."\nJMP :goto_"..JMP..("\nSETTABLE v36 v0 v36"):rep(1).."\n:goto_"..JMP
end)
code = string.dump(load(code), true)

randomly_strings = function(...)
return (math.random(128, 255))
end

really_hex = {
 [1] = string.char(0x00, 0x63, 0x01, 0xff, 0x7f, 0x17),
 [2] = string.char(0x80, 0x00, 0x1f, 0x00, 0x80)
 }

modified_hex = {
 [1] = string.char(0x00, randomly_strings(), randomly_strings(), randomly_strings(), randomly_strings(), randomly_strings()),
 [2] = string.char(0x80, 0x00, 0xe4, 0x00, 0x80)
 }

pairs_are = {
 [1] = 0x00,
 [2] = 0x01
 }

for i in ipairs(pairs_are) do
code = string.gsub(code, really_hex[i], modified_hex[i])
end
str=str..("\x00"):rep(num*4-#str)
print(num)
code=code:gsub("(\x17...)"..("\x82\x76\x00\x00"):rep(num),"%1"..str)

_G["os"]["remove"](LasmTmp)
w = _G["io"]["open"](_G["gg"]["EXT_STORAGE"] .. "/" .. "Script_enc.lua", "w")
w = w:write(code):write("[" .. string.format("%02x", #code) .. "]")
w = w:close()
w = nil
_G["gg"]["toast"]("𝑬𝒏𝒄𝒓𝒚𝒑𝒕𝒊𝒏𝒈 𝒀𝒐𝒖𝒓 𝒔𝒄𝒓𝒊𝒑𝒕 𝒊𝒔 𝒅𝒐𝒏𝒆 ️✅", _G["gg"]["sleep"](2000))
-- _G["gg"]["sleep"](1600)
_G["gg"]["alert"]("❗Script Saved to:" .. "/sdcard" .. "/" .. "Script_enc.lua", "ok")