FROM alpine:3.18 as builder

RUN apk --no-cache add git build-base cmake python3 \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip

RUN git clone --recursive https://github.com/leejet/stable-diffusion.cpp

RUN cd stable-diffusion.cpp \
    && mkdir build \
    && cd build \
    && cmake .. \
    && cmake --build . --config Release

#WORKDIR /output
WORKDIR /models
ENTRYPOINT [ "/stable-diffusion.cpp/build/bin/sd" ]

# FROM alpine:3.18 as runtime
# COPY --from=builder /stable-diffusion.cpp/build/bin/sd /sd
# ENTRYPOINT [ "/sd" ]
