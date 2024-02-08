FROM alpine

RUN apk add --no-cache xmlstarlet
COPY generate.sh /

CMD /generate.sh
