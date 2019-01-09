import time
from toripchanger import TorIpChanger

ip_changer = TorIpChanger(tor_password='password', tor_port=9051, local_http_proxy='127.0.0.1:8118')

for i in range(10):
    ip_changer.get_new_ip()

    time.sleep(5)