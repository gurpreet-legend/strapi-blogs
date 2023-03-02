
FROM node:16-alpine
# Installing libvips-dev for sharp Compatibility
#RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
ENV HOST=0.0.0.0
ENV PORT=1337
ENV APP_KEYS=nto+bN2Q2bhkEou3//xJIw==,TQXXKP+uavgpuikSC/qPLw==,9MvACyMiFWV3HFpynysBIg==,9Su6DCwej6YGbZwzEJGWbA==
ENV API_TOKEN_SALT=urQWm+ln10wdTP6eWqVMzg==
ENV ADMIN_JWT_SECRET=K19J5yCBtiJkLzc487BFpw==
ENV JWT_SECRET=42lyZkV2+G8kI18tf5ZtqA==
WORKDIR /opt/
COPY ./package.json ./yarn.lock ./
ENV PATH /opt/node_modules/.bin:$PATH
#RUN npm config set sharp_binary_host "https://npmmirror.com/mirrors/sharp" && npm config set sharp_libvips_binary_host "https://npmmirror.com/mirrors/sharp-libvips" && npm install -g  npm@9.5.1 sharp
RUN yarn config set network-timeout 600000 -g && yarn install
WORKDIR /opt/app
COPY ./ .
RUN yarn build
EXPOSE 1337
CMD ["yarn", "develop"]
