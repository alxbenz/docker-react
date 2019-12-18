# define base image as a stage
FROM node:alpine AS builder
# set working dir
WORKDIR /app
# copy files
COPY package.json .
# run a command
RUN npm install
# copy files
COPY . .
# run a command
RUN npm run build
# end of stage "builder"

# define base image as another step
FROM nginx
# exposes a certain port # used by AWS automatically
EXPOSE 80
# copy from "builder" stage to current image
COPY --from=builder /app/build /usr/share/nginx/html