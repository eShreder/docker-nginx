LOGS_DIR="$(pwd)/logs"
STATIC_DIR="$(pwd)/static"
ACCESS_LOG="$(pwd)/logs/access.log"
ERROR_LOG="$(pwd)/logs/error.log"

test -d "$LOGS_DIR" || mkdir $LOGS_DIR
test -d "$STATIC_DIR" || mkdir $STATIC_DIR
test -f "$ACCESS_LOG" || touch $ACCESS_LOG
test -f "$ERROR_LOG" || touch $ERROR_LOG

docker run \
 -d \
 --rm \
 --network=services \
 -p 443:443 \
 -p 80:80 \
 -v /etc/letsencrypt:/etc/letsencrypt \
 -v $ACCESS_LOG:/dev/stdout \
 -v $ERROR_LOG:/dev/stderr \
 -v `pwd`/config/nginx.conf:/etc/nginx/nginx.conf \
 -v `pwd`/config/conf.d:/etc/nginx/conf.d \
 -v `pwd`/static:/var/html/eshreder.me/static \
 --name=nginx \
 nginx
