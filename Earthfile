VERSION 0.5

elixir-base:
    FROM elixir:1.12.2-alpine
    WORKDIR /app
    RUN apk add --no-progress --update openssh-client git build-base
    RUN mix local.rebar --force && mix local.hex --force

deps:
    ARG MIX_ENV
    FROM +elixir-base
    ENV MIX_ENV="$MIX_ENV"
    COPY mix.exs .
    COPY mix.lock .
    RUN mix deps.get --only "$MIX_ENV"
    RUN mix deps.compile

lint:
    FROM --build-arg MIX_ENV="dev" +deps
    COPY --dir lib .
    COPY .formatter.exs .
    RUN mix deps.unlock --check-unused
    RUN mix format --check-formatted
    RUN mix compile --warnings-as-errors

test:
    FROM earthly/dind:alpine
    WORKDIR /test
    
    COPY --dir config lib test .
    
    WITH DOCKER --load elixir:latest=+deps --build-arg MIX_ENV="test"
        RUN set -e; \

        docker run \
            --rm \
            -e MIX_ENV=test \
            -e EX_LOG_LEVEL=warn \
            --network host \
            -v "$PWD/config:/app/config" \
            -v "$PWD/lib:/app/lib" \
            -v "$PWD/test:/app/test" \
            -w /app \
            --name queuetopia_bug_reporter \
            elixir:latest mix test;
    END

check-tag:
    ARG TAG
    FROM +elixir-base
    COPY mix.exs .
    ARG APP_VERSION=$(mix app.version)
    IF [ ! -z $TAG ] && [ ! $TAG == $APP_VERSION ]
        RUN echo "TAG '$TAG' has to be equal to APP_VERSION '$APP_VERSION'" && false
    END