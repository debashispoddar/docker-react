# Alias 
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx 
# Copy from our container /app directory to the nginx default path
COPY --from=builder /app/build /usr/share/nginx/html
# Default command from nginx starts the nginx server , we dont have to manually start
