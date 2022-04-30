FROM node:17.1.0

# run every hour by default, use `SCHEDULE=NONE` to run directly
ENV SCHEDULE "0 * * * *"

# clean eliminates the need to manually `rm -rf` the cache
RUN set -eux; \
  \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    bash \
    nano less \
    chromium chromium-driver \
    cron \
    git; \
  apt-get clean;

WORKDIR /app
RUN mkdir lib; git clone https://github.com/lunch-money/lunch-money-js.git lib/lunch-money;
COPY . ./

# run after copying source to chache the earlier steps
RUN npm install --no-optional

CMD ["bash", "cron.sh"]
