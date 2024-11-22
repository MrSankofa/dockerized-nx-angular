# Step 1: Build the Angular app
FROM node:18 AS build

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all files
COPY . .

# Build the app
RUN npm run build:my-workspace

# Step 2: Serve the app with Nginx
FROM nginx:latest

COPY --from=build /app/dist/my-workspace /usr/share/nginx/html

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]