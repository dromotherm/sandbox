"""high level API"""
import asyncio
import signal
from dbus_next.aio import MessageBus
from dbus_next.constants import BusType

def message_handler(msg):
    print(msg)

async def main():
    stop_event = asyncio.Event()

    loop = asyncio.get_event_loop()
    loop.add_signal_handler(signal.SIGINT, stop_event.set)
    loop.add_signal_handler(signal.SIGTERM, stop_event.set)

    bus = await MessageBus(bus_type=BusType.SESSION).connect()
    bus_intr = await bus.introspect("dbus.next.example.service", '/example/path')
    bus_obj = bus.get_proxy_object("dbus.next.example.service", '/example/path', bus_intr)
    print(f'bus unique name {bus.unique_name}')
    interface = bus_obj.get_interface('example.interface')

    #bus.add_message_handler(message_handler)
    interface.on_changed(message_handler)
    interface.on_signal_simple(message_handler)
    result = await interface.call_echo("bravo")
    print(result)

    await stop_event.wait()

asyncio.run(main())
