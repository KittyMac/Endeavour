FROM swiftarm/swift:5.6.2-ubuntu-focal as builder

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libjavascriptcoregtk-4.0-dev \
    libatomic1

RUN rm -rf /var/lib/apt/lists/*


WORKDIR /root/EndeavourApp
COPY ./Makefile ./Makefile
COPY ./Package.swift ./Package.swift
COPY ./Sources ./Sources
COPY ./Tests ./Tests

RUN swift package update
RUN swift build --configuration release

FROM swiftarm/swift:5.6.2-ubuntu-focal-slim as app

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get -q install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libjavascriptcoregtk-4.0-dev \
    libatomic1
    
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /root
COPY --from=builder /root/EndeavourApp/.build/release/EndeavourApp .

