"""send message - works only if dbus_service is running"""
from dbus_next import Message, MessageType, BusType
from dbus_next.aio import MessageBus

import asyncio

loop = asyncio.get_event_loop()
bus_type = BusType.SESSION

async def main():
    bus = await MessageBus(bus_type=bus_type).connect()

    message = Message(destination="dbus.next.example.service",
                      interface='example.interface',
                      path='/example/path',
                      member="Echo",
                      signature='s',
                      body=["tomate rouge"],
    )

    result = await bus.call(message)

    assert result.message_type is not MessageType.ERROR

    print(result.body)

loop.run_until_complete(main())
