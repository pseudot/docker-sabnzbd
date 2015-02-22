# sabnzbd on Centos 6.5 docker container

## Docker container for running sabnzbd.
  
  Access via https://localhost:9090/sabnzbd
  SSL certificate are enabled with a self-signed certificate.

  Download locations
    /opt/downloads/tmp

    /opt/downloads/completed        for completed downloads. Should be shared with sickbeard

    /opt/downloads/watch

    /opt/downloads/postprocess

    /opt/downloads/backup


## Requires 
  Docker 1.3+

## Container setup

  When running these items should be exposed or mapped.
  
  Volumes
    - /var/log/sabnzbd                Contains sabnzbd logs

    - /root/.sabnzbd/                   for sabnzbd config file

    - /opt/downloads/        download folder

  Map Ports
    - 8080 ->  8080         SABnzbd page

    - 9090 ->  9090         SABnzbd secure page
  
    - 9001 ->  44091        Supervisor page

## To build container

  > docker build --rm=true -t="sabnzbd" .

## To run container

  > docker run --name sabnzbd -v /mnt/downloads:/opt/downloads/  -p 44091:9091 -p 9090:9090

## Backup config file

  > CONT=`docker ps -a | grep sabnzbd | awk '{ print $1 }'`
  > docker cp $CONT:/root/.sabnzbd/sabnzbd.ini $PWD