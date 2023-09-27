"""dbus-python is deprecated
https://ggargblogs.wordpress.com/2020/09/06/using-dbus-api-in-python-for-managing-services-in-linux/
"""

import sys 
import dbus
 
bus = dbus.SystemBus()
systemd = bus.get_object('org.freedesktop.systemd1', '/org/freedesktop/systemd1')
manager = dbus.Interface(systemd, 'org.freedesktop.systemd1.Manager')

def is_service_active(service):
    """
    is_service_active method will check if service is running or not.
    It raise exception if there is service is not loaded
    Return value, True if service is running otherwise False.
    :param str service: name of the service
    """
    try:
        unit = manager.GetUnit(service)
    except:
        return f'service {service} inactif'
    return f'service {service} actif : unit is {unit}'
 
if __name__ == "__main__":
    print(is_service_active("docker.service"))
