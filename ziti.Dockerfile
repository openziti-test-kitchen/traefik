FROM golang
ENV GO111MODULE=on
ARG ARCH="amd64"
ARG OS="linux"
# ENV GOFLAGS=-mod=vendor
ENV APP_USER=appuser
ENV APP_GROUP=appgroup
ENV APP_HOME=/app
ARG GROUP_ID=1000
ARG USER_ID=1000
RUN groupadd --gid $GROUP_ID $APP_GROUP && useradd -m -l --uid $USER_ID --gid $GROUP_ID $APP_USER
RUN mkdir -p $APP_HOME
RUN chown -R $APP_USER:$APP_GROUP $APP_HOME
RUN chmod -R 0777 $APP_HOME
USER $APP_USER
WORKDIR $APP_HOME
ADD . $APP_HOME
RUN go mod download
RUN go build -o traefik ./cmd/traefik
VOLUME /tmp
EXPOSE 80
ENV PATH="/app/traefik:${PATH}"
CMD ./traefik --log.level=DEBUG
