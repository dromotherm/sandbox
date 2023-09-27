from dbus_next.service import ServiceInterface, method, signal, dbus_property
from dbus_next.aio.message_bus import MessageBus
from dbus_next import Variant, BusType

bus_type = BusType.SESSION
#bus_type = BusType.SYSTEM

import asyncio


class ExampleInterface(ServiceInterface):
    def __init__(self, name):
        super().__init__(name)
        self._string_prop = 'kevin'

    @method(name='Echo')
    def Echo(self, what: 's') -> 's':
        print("somebody is calling me")
        what=f'je suis {self._string_prop} et je dis {what}'
        return what

    @method()
    def EchoMultiple(self, what1: 's', what2: 's') -> 'ss':
        return [what1, what2]

    @method()
    def GetVariantDict(self) -> 'a{sv}':
        return {
            'foo': Variant('s', 'bar'),
            'bat': Variant('x', -55),
            'a_list': Variant('as', ['hello', 'world'])
        }

    @dbus_property(name='StringProp')
    def string_prop(self) -> 's':
        return self._string_prop

    @string_prop.setter
    def string_prop_setter(self, val: 's'):
        self._string_prop = val

    @signal()
    def Changed(self) -> 'b':
        return True

    @signal(name='signalSimple')
    def signal_simple(self) -> 's':
        print("emitting a signal")
        return 'signal > hello'

    @signal()
    def signal_multiple(self) -> 'ss':
        print("having a multiple signal")
        return ['hello', 'world']


async def main():
    name = 'dbus.next.example.service'
    path = '/example/path'
    interface_name = 'example.interface'

    bus = await MessageBus(bus_type=bus_type).connect()
    interface = ExampleInterface(interface_name)
    bus.export(path, interface)
    await bus.request_name(name)
    
    print(f'bus unique name {bus.unique_name}')

    await asyncio.sleep(2)
    #interface.Changed()
    interface.signal_simple()

    print(f'service up on name: "{name}", path: "{path}", interface: "{interface_name}"')
    await bus.wait_for_disconnect()

asyncio.get_event_loop().run_until_complete(main())
