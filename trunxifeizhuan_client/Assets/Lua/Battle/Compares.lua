local Compares = {
	[1] = function (a,b) return a == b; end;
	[2] = function (a,b) return a ~= b; end;
	[3] = function (a,b) return a > b; end;
	[4] = function (a,b) return a < b; end;
	[5] = function (a,b) return a <= b; end;
	[6] = function (a,b) return a >= b; end;
}

return Compares;