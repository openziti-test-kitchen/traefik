FROM scratch
COPY script/ca-certificates.crt /etc/ssl/certs/
COPY dist/traefik /
copy traefik-prometheus.json /
EXPOSE 80
VOLUME ["/tmp"]
ENTRYPOINT ["/traefik"]
