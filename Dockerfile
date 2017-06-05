FROM node:8

RUN apt-get update && apt-get install -y python git-core build-essential zlib1g-dev latexmk texlive-full

RUN git clone https://github.com/sharelatex/clsi-sharelatex.git /app

WORKDIR /app

# Install app dependencies
#COPY package.json /src/package.json
#RUN cd /src; npm install
RUN npm install
RUN npm install -g grunt-cli
RUN grunt install
#RUN tlmgr init-usertree
#RUN tlmgr install scheme-full

RUN sed -i 's/localhost/0.0.0.0/g' config/settings.defaults.coffee
RUN mkdir /app/compiles /app/cache

EXPOSE 3013

CMD ["grunt", "run"]
