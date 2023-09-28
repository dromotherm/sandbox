"""a customized interface"""
from dbus_next.service import ServiceInterface, method, signal, dbus_property

SERVICE_NAME = 'dbus.next.example.service'
PATH = '/example/path'
INTERFACE_NAME = 'example.interface'

class ExampleInterface(ServiceInterface):
    def __init__(self, name):
        super().__init__(name)
        self._string_prop = 'kevin'

    @method(name='Echo')
    def Echo(self, what: str) -> str:
        print("a client is invoking me")
        what=f'I am {self._string_prop} and I say {what}'
        return what

    @signal(name='signalSimple')
    def signal_simple(self) -> str:
        print("emitting a signal")
        return 'signal > hello'
