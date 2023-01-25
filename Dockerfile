# Stage 0, "build-stage", based on Node.js, to build and compile the frontend
FROM node:19.4.0 as build
WORKDIR /usr/local/app
COPY ./ /usr/local/app/
RUN npm install
RUN npm run build -- --output-path=./dist/out
#RUN npm run build -- --output-path=./dist/out --configuration $configuration

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:latest
#Copy ci-dashboard-dist
COPY --from=build /usr/local/app/dist/out /usr/share/nginx/html
#Copy default nginx configuration
#COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
