# tftpd
simple container for tftp server

intended for use in greta wwulf nodes that don't have tftpd binary


docker pull ghcr.io/tin6150/tftpd:main
docker run -it --rm --entrypoint /bin/bash tftpd:main


docker run -it -p 69:69/udp --entrypoint /usr/sbin/in.tftpd -v /var/lib/tftpboot:/tftpboot      registry:443/tftpd:main


SERVER=s02
/usr/bin/tftp $SERVER -c get hello_world.txt


singularity pull --name tftpd.sif docker://ghcr.io/tin6150/tftpd:main

xref: 
https://github.com/cseelye/pxe-server/tree/main
https://github.com/kalaksi/docker-tftpd


