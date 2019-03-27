FROM davidsiaw/musicbot-base

EXPOSE 3000
COPY package.json /srv/
WORKDIR /srv
RUN npm install
COPY index.js run.sh /srv/
CMD ["sh", "run.sh"]
