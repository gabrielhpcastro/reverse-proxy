# Reverse proxy

This repo contains the configuration to deploy a reverse proxy using docker and
nginx in order to serve local projects using HTTPS.

## SSL certificate

In order to have the reverse proxy in Docker you will need a valid SSL certificate
and key.

These are available in the ssl folder. They are valid until **28.05.2025**. In case
the certificate and key are no longer valid, follow the steps bellow to create new
ones and push them to the repository. _💡 Don't forget to update the date above._

### Creating a new SSL certificate and key

Run the command bellow to generate a new pair of key/certificate:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./ssl/key.pem -out ./ssl/cert.pem
```

> 💡 When prompted for information inform at least one of the values, otherwise the
> creation will fail.

> 💡 The new certificate and key will be valid for 365 days.

## Deploying the reverse proxy

- In order to deploy your reverse proxy first you should build the docker image
  by running:

```bash
docker build . -t reverse-proxy
```

- And once the docker image is built, deploy the container by running:

```bash
docker run -p 433:433 -d reverse-proxy
```

The proxy should already be working. If you try to access https://localhost you
should be redirected to the service running on port http://localhost:8080.

> 💡 If you want your reverse proxy to redirect you to another port or to an
> https server you can provide the following env variables when running
> `docker run`:
> `-e PORT={port_number}` to set the server port (default is 8080)
> `-e SCHEME={http | https}` to set the server scheme (default is http)

### Setting a URL in the hosts file

If you want to have a custom URL for your reverse proxy, simply edit your **hosts**
file to include a redirection from the URL to your localhost.

> 💡 The hosts file is located in **/etc/hosts** on mac.

> 💡 You might need root (sudo) privileges to edit the file.

**hosts**

```
# Add this to your hosts file
127.0.0.1       example.com # Replace with the desired URL
```

Now when accessing https://example.com in your browser, you should also be
redirected to the service running on port 8080.

## Health check

To make sure the proxy is running properly, after starting your docker container
you can go to https://localhost/proxy_health and you should see an "`I am alive!`" text
in your browser.
