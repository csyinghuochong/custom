local person_pb = require 'Protol.person_pb'
local protol_data = nil;
function Decoder()  
    local msg = person_pb.Person()
    msg:ParseFromString(protol_data)
    print('person_pb decoder: '..tostring(msg))
end

function Encoder()                           
    local msg = person_pb.Person()
    msg.id = 1024
    msg.name = 'foo'
    msg.email = 'bar'                                    
    local pb_data = msg:SerializeToString()
    protol_data = pb_data
end

Encoder();
Decoder();