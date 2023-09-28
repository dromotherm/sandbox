"""a service
the custom interface is in dbus_tools
"""
import asyncio
import signal
from dbus_next.aio import MessageBus
from dbus_next import Variant, BusType
from dbus_tools import ExampleInterface, SERVICE_NAME, PATH, INTERFACE_NAME

async def waiter(event, interface, bus):
    print('waiting for it ...')
    await event.wait()
    interface.signal_simple()
    print('... got it!')

async def main():
    event = asyncio.Event()
    loop = asyncio.get_event_loop()
    loop.add_signal_handler(signal.SIGINT, event.set)
    loop.add_signal_handler(signal.SIGTERM, event.set)

    bus = await MessageBus(bus_type=BusType.SESSION).connect()
    interface = ExampleInterface(INTERFACE_NAME)
    bus.export(PATH, interface)
    await bus.request_name(SERVICE_NAME)
    
    print("*****************DETAILS**********************************")
    print("INVOKING introspect()")
    details = interface.introspect()
    print("    AVAILABLE SIGNALS")
    for interface_signal in details.signals:
        print(f'    - {interface_signal.name}')
    print("    AVAILABLE METHODS")
    for method in details.methods:
        print(f'    - {method.name}')
    print("INTERFACE HAS BEEN EXPORTED TO THE BUS ")
    print(f'    {bus._path_exports}')
    print(f'unique name {bus.unique_name}')
    print("service up")
    print(f'name: {SERVICE_NAME}')
    print(f'path: {PATH}')
    print(f'interface: {INTERFACE_NAME}')
    print("**********************************************************")
    
    waiter_task = asyncio.create_task(waiter(event, interface, bus))
    await waiter_task

asyncio.run(main())
