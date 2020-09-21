FROM alpine as build

RUN apk add --no-cache --virtual vscode-build-dependencies \
    git \
    build-base \
    pkgconfig \
    npm \
    nodejs \
    yarn \
    python3-dev \
    libx11-dev \
    libxkbfile-dev \
    libsecret-dev

ENV VSCODE_REVISION 1.49.1
RUN git clone --depth 1 --branch ${VSCODE_REVISION} https://github.com/microsoft/vscode.git /vscode

WORKDIR /vscode

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN yarn

FROM alpine

RUN apk add --no-cache --virtual vscode-runtime-dependencies \
    nodejs \
    libx11 \
    libxkbfile \
    libsecret

COPY --from=build /vscode /vscode

EXPOSE 8080

WORKDIR /vscode

CMD yarn web --port 8080 --host 0.0.0.0 --scheme http

