
# Step 1
FROM node:10-alpine as build-step
RUN apk update && apk add bash
RUN mkdir /app
WORKDIR /app
COPY package.json /app
RUN yarn install
COPY . /app
RUN yarn deploy

# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=build-step /app/build /usr/share/nginx/html