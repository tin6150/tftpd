# tftpd
simple container for tftp server

intended for use in greta wwulf nodes that don't have tftpd binary


docker pull ghcr.io/tin6150/tftpd:main
docker run -it --rm --entrypoint /bin/bash tftpd:main


# start server:

docker run -it -p 69:69/udp -v /global/sysbase/tftp/tftpboot:/tftpboot   registry.greta.local:443/tftpd:main   # this work, don't req full path from client


docker run -it -p 69:69/udp --entrypoint /usr/sbin/in.tftpd -v /global/tftpboot:/tftpboot   registry:443/tftpd:main -L -vvv  
^^ above worked, but tftp client need to specify full path fetched files             

# client test
~/app/centos7/tftp  s02 -c get /tftpboot/hello_world.txt


SERVER=s02
/usr/bin/tftp $SERVER -c get hello_world.txt   #  seems to work, but file saved inside container.  so end up copying the binary to the host.


nc

~~~~~

singularity pull --name tftpd.sif docker://ghcr.io/tin6150/tftpd:main

xref: 
https://github.com/cseelye/pxe-server/tree/main
https://github.com/kalaksi/docker-tftpd





