# Stage 1: Build the React app
FROM node:18-alpine as builder

WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application files (including public folder)
COPY . .

# Set environment variable to use OpenSSL legacy provider
ENV NODE_OPTIONS=--openssl-legacy-provider

# Build the app
RUN npm run build

# Stage 2: Serve the built app with Nginx
FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
