#!/usr/bin/env python

from pymodbus.constants import Endian
from pymodbus.payload import BinaryPayloadDecoder
from pymodbus.payload import BinaryPayloadBuilder
from pymodbus.client.sync import ModbusTcpClient as ModbusClient

modbus_IP = "192.168.4.2"   # ip address of client to retrieve data from
modbus_port = 502
# sofrel modbus number is 3
unitId = 3
register = 54629
value = 6

c = ModbusClient(modbus_IP,modbus_port)
if c.connect():
    print("Opening modbusTCP connection: {} @ {}".format(modbus_port,modbus_IP))
    rr=c.read_holding_registers(54621,2,unit=unitId)
    decoder = BinaryPayloadDecoder.fromRegisters(rr.registers, byteorder=Endian.Big, wordorder=Endian.Big)
    rValD = decoder.decode_32bit_float()
    print(rValD)
    builder = BinaryPayloadBuilder(byteorder=Endian.Big, wordorder=Endian.Big)
    builder.add_32bit_float(value)
    payload = builder.build()
    rq=c.write_registers(register,payload,skip_encode=True,unit=unitId)
    assert(not rq.isError())
    c.close()
else:
    print("Connection failed")
