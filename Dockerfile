# Use an existing image as a base
FROM nginx:latest

# Set the working directory to the default Nginx web root
WORKDIR /usr/share/nginx/html

# Copy the contents of the 'tutu' folder to the working directory in the container
COPY tutu/ .

# Expose port 80 for incoming traffic
EXPOSE 80

# Start Nginx and keep the container running in the foreground
CMD ["nginx", "-g", "daemon off;"]
