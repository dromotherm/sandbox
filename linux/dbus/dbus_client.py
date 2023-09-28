"""high level API"""
import asyncio
import signal
from dbus_next.aio import MessageBus
from dbus_next.constants import BusType
from dbus_tools import ExampleInterface, SERVICE_NAME, PATH, INTERFACE_NAME

def dbus_message_handler(msg):
    print(f'member:{msg.member} path:{msg.path} interface: {msg.interface} body:{msg.body}')

def signal_handler(msg):
    print(msg)

async def main():
    stop_event = asyncio.Event()

    loop = asyncio.get_event_loop()
    loop.add_signal_handler(signal.SIGINT, stop_event.set)
    loop.add_signal_handler(signal.SIGTERM, stop_event.set)
    
    bus = await MessageBus(bus_type=BusType.SESSION).connect()
    bus_intr = await bus.introspect(SERVICE_NAME, PATH)
    bus_obj = bus.get_proxy_object(SERVICE_NAME, PATH, bus_intr)
    print(f'bus unique name {bus.unique_name}')
    interface = bus_obj.get_interface(INTERFACE_NAME)

    #bus.add_message_handler(dbus_message_handler)

    # test : listening to signal
    interface.on_signal_simple(signal_handler)

    # test : using method echo
    #result = await interface.call_echo("bravo")
    #print(result)

    await stop_event.wait()

asyncio.run(main())
