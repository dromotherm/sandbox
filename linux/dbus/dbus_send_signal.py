"""send signals - works if dbus_service.py is closed and dbus_client is up
not practical use - just for acquiring knowledge
"""
from dbus_next import Message, MessageType, BusType
from dbus_next.aio import MessageBus
from dbus_tools import ExampleInterface, INTERFACE_NAME, SERVICE_NAME, PATH

import asyncio

loop = asyncio.get_event_loop()
bus_type = BusType.SESSION

async def main():
    
    bus = await MessageBus(bus_type=bus_type).connect()
    
    interface = ExampleInterface(INTERFACE_NAME)
    bus.export(PATH, interface)
    resp = await bus.request_name(SERVICE_NAME)
    print(resp)
    
    # high level signal send
    interface.signal_simple()
    
    # low level
    msg = Message.new_signal(
        interface=INTERFACE_NAME,
        path=PATH,
        member="signalSimple",
        signature='s',
        body=["a signal"],
    )
    await bus.send(msg)

loop.run_until_complete(main())
