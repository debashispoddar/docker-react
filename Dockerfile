# Alias 
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
#See this is RUN npm run build not CMD ["npm", "run", "build"], since this is 
# we are asking it to run at once and not making a default [CMD] for the  container
RUN npm run build
#Till this point , it the temporary container , which is required to spit out the build files which
# will be required in the ngnix step


FROM nginx 
EXPOSE 80
# Copy from our container /app directory(build files are generated under /build) to the nginx default path
COPY --from=builder /app/build /usr/share/nginx/html
# Default command from nginx starts the nginx server , we dont have to manually start
