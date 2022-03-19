FROM swiftarm/swift:5.5.2-ubuntu-bionic as builder

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get -q install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /root/EndeavourApp
COPY ./Makefile ./Makefile
COPY ./Package.swift ./Package.swift
COPY ./meta ./meta
COPY ./Sources ./Sources
COPY ./Tests ./Tests

RUN swift package update
RUN swift test
RUN swift build --configuration release

FROM swiftarm/swift:5.5.2-ubuntu-bionic-slim

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get -q install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /root
COPY --from=builder /root/EndeavourApp/.build/release/EndeavourApp .

