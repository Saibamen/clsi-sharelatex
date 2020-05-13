FROM node:10.19.0

RUN apt-get update && apt-get install -y python git-core build-essential zlib1g-dev latexmk texlive-full

RUN git clone https://github.com/overleaf/clsi.git /app

WORKDIR /app

#RUN chmod 0755 ./install_deps.sh && ./install_deps.sh
#ENTRYPOINT ["/bin/sh", "entrypoint.sh"]

# Install app dependencies
RUN npm install

RUN sed -i 's/localhost/0.0.0.0/g' config/settings.defaults.js
RUN mkdir -p /app/cache /app/compiles /app/db \
&& chown node:node /app/cache /app/compiles /app/db

EXPOSE 3013

CMD ["node", "--expose-gc", "app.js"]
