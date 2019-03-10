FROM davidsiaw/musicbot-base

COPY package-lock.json package.json /srv/
RUN npm install

COPY index.js run.sh /srv/
EXPOSE 3000
WORKDIR /srv
CMD ["sh", "run.sh"]
