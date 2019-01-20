# Production build, not for running local. No volume will be needed
# Define a builder phase
FROM node:alpine as builder

WORKDIR /app
COPY package.json yarn.lock ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx
COPY --from=builder app/build usr/share/nginx/html
# Note: The dafault command for nginx is to start, no need for RUN 

