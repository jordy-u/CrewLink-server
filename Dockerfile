# ottomated/crewlink-server
FROM node:14

# Make a directory for the app, give node user permissions
RUN mkdir /app && chown node:node /app

# Change to the /app directory *and* make it the default execution directory
WORKDIR /app

# Copy the repo contents from the build context into the image
COPY ./ /app/

# Give ownership to the app folder to user 'node'.
RUN chown -R node /app

# Do all remaining actions as node, and start the image as node
USER node

# Install NPM packages
RUN yarn install

# Compile project
RUN yarn compile

# Tell the Docker engine the default port is 9736
EXPOSE 9736 443

# Run the app when the container starts
CMD ["node", "dist/index.js"]
