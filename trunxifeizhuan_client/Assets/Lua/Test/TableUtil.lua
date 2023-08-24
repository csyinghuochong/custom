local mString = require "string"
TableUtil = {};

function TableUtil.PrintTable(value,printIndex)
	index = printIndex or 0;
	tab  = "";
	for i = 0,index do
		tab = tab .. " ";
	end

	local result = "";
	result = result .. tab .. "\n{";

	for k,v in pairs(value) do
		if type(v) == "table" then
			result = result .. mString.format("\n%s%s=%s,",tab,k,TableUtil.PrintTable(v,index + 1));
		else
			result = result .. mString.format("\n%s%s=%s,",tab,k,v);
		end
	end
	result = result .. tab .. "\n}";

	if not printIndex then
		print(result);
	end 

	return result;
end
