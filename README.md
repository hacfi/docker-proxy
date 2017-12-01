# Docker proxy

Docker proxy based on nginx to have zero downtime deployments. It exposes two
ports so you can preview your next version before switching your live system.
Port 80 is meant for your live system and this is where your main load balancer
should point to. You can setup a secondary load balancer which points to port
8080 so you can preview your next version.


## Build image

```
docker build -t docker-proxy .
```


## Usage

Start the proxy with the following command:

```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 80:80 -p 8080:8080 --name docker-proxy docker-proxy
```

Of course you can use different ports like `-p 5000:80 -p 5001:8080` or just
expose port 80 if you don’t need the second port to preview a release.

Start your dockerized application and then run

```
docker exec -it docker-proxy proxy1 <CONTAINER_ID>
```

to switch proxy 1 to that container. You can now access this application on port
80 (or whatever port you exposed port 80 on).

When you release a new version start the new container and run

```
docker exec -it docker-proxy proxy2 <NEW_CONTAINER_ID>
```

to be able to preview it on port 8080.

When everything looks good just run

```
docker exec -it docker-proxy proxy1 <NEW_CONTAINER_ID>
```

to release the new version on the main port.
