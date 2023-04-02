# Use Node.js v6.9.2 as base image
FROM node:6.9.2

# Expose port 8080 for incoming traffic
EXPOSE 8080

# Copy the server.js file from the current directory to the image
COPY server.js .

# Set the default command to run the server.js file with Node.js
CMD node server.js
