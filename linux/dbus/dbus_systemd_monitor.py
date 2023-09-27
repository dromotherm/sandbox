"""catches systemd services status changes"""
import asyncio
import signal
import os

from dbus_fast.aio import MessageBus
from dbus_fast.message import Message
from dbus_fast.constants import BusType, MessageType

def message_handler(msg):
    body = msg.body
    if msg.member == 'JobNew':
        print(f'New Job: {body[2]}')
    if msg.member == 'JobRemoved':
        print(f'Job Finished: {body[2]}, result: {body[3]}')

async def main():
    stop_event = asyncio.Event()
    loop = asyncio.get_event_loop()
    loop.add_signal_handler(signal.SIGINT, stop_event.set)
    loop.add_signal_handler(signal.SIGTERM, stop_event.set)

    bus = await MessageBus(bus_type=BusType.SYSTEM).connect()

    reply = await bus.call(Message(
        destination='org.freedesktop.DBus',
        path='/org/freedesktop/DBus',
        interface='org.freedesktop.DBus',
        member='AddMatch',
        signature='s',
        body=["interface='org.freedesktop.systemd1.Manager'"],
        serial=bus.next_serial()
    ))
    #print(reply)
    assert reply.message_type == MessageType.METHOD_RETURN
    bus.add_message_handler(message_handler)
    await stop_event.wait()

asyncio.run(main())
