# Use a base image with necessary dependencies
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy application source code
COPY . .

# Expose the port on which the app runs
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
