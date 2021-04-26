alpine:
    FROM alpine:3.7
    RUN apk update && apk add bash bats
    ARG HTTP_CLIENT=""
    IF [ "$HTTP_CLIENT" = "wget" ]
        # do nothing, as alpine supplies wget via busybox
    ELSE
        IF [ -n "$HTTP_CLIENT" ]
            RUN apk update && apk add "$HTTP_CLIENT"
        END
        RUN unlink /usr/bin/wget # points to busybox by default
    END

ubuntu:
    FROM ubuntu:21.04
    ENV DEBIAN_FRONTEND=noninteractive
    RUN apt update && apt install -y bats
    ARG HTTP_CLIENT=""
    IF [ -n "$HTTP_CLIENT" ]
        RUN apt update && apt install -y "$HTTP_CLIENT"
    END

fedora:
    FROM fedora:34
    RUN dnf install -qy bats
    ARG HTTP_CLIENT=""
    IF [ -n "$HTTP_CLIENT" ]
        RUN dnf install -qy "$HTTP_CLIENT"
    END

lint:
    FROM --platform=linux/amd64 alpine:3.13
    RUN apk add --update --no-cache shellcheck
    WORKDIR /snips
    COPY weather/weather .

    # TODO: once the shellcheck warnings are fixed, remove the echo and --no-cache option.
    # the echo is included here so we will continue the build, and the --no-cache so that we always run shellcheck
    # even if the script hasn't changed, so we can print out the warnings.
    RUN --no-cache shellcheck * || echo "treating all shellcheck issues as warnings rather than failures"


test-weather:
    ARG HTTP_CLIENT=curl
    ARG OS=ubuntu
    FROM +$OS
    WORKDIR /snips
    COPY --dir weather .
    RUN mkdir tests
    COPY tests/weather.bats tests/.
    IF [ "$OS" = "alpine" ] && [ "$HTTP_CLIENT" = "httpie" ]
        RUN echo "running weather update on alpine+httpie doesnt work" # TODO remove this once it is fixed.
    ELSE
        RUN bats tests/weather.bats
    END

test-weather-all:
    BUILD \
        --build-arg OS=ubuntu \
        --build-arg OS=alpine \
        --build-arg OS=fedora \
        --build-arg HTTP_CLIENT=curl \
        --build-arg HTTP_CLIENT=wget \
        --build-arg HTTP_CLIENT=httpie \
        +test-weather

bats:
    BUILD +test-weather-all

all:
    BUILD +lint
    BUILD +bats
