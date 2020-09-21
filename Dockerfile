FROM alpine

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

RUN yarn

EXPOSE 8080

WORKDIR /workspace

CMD yarn web --port 8080 --host 0.0.0.0 --scheme http

