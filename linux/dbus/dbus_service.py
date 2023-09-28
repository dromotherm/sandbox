"""a service
the custom interface is in dbus_tools
"""
import asyncio
import signal
from dbus_next.aio import MessageBus
from dbus_next import Message, BusType
from dbus_tools import ExampleInterface, SERVICE_NAME, PATH, INTERFACE_NAME

async def wait_for_closing(event, interface, bus):
    await event.wait()
    msg = Message.new_signal(
        interface=INTERFACE_NAME,
        path=PATH,
        member="signalSimple",
        signature='s',
        body=["got signal : service closing"],
    )
    await bus.send(msg)
    print('...we are closing...')

async def main():
    stop_event = asyncio.Event()
    loop = asyncio.get_event_loop()
    loop.add_signal_handler(signal.SIGINT, stop_event.set)
    loop.add_signal_handler(signal.SIGTERM, stop_event.set)

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
    
    wait_for_closing_task = asyncio.create_task(
        wait_for_closing(stop_event, interface, bus)
    )
    await wait_for_closing_task

asyncio.run(main())
