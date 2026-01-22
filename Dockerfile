# =========================================
# Stage 1: Build the React.js Application
# =========================================
ARG NODE_VERSION=24.12.0-alpine
ARG NGINX_VERSION=alpine3.22
ARG PORT=8080

# Use a lightweight Node.js image for building (customizable via ARG)
FROM node:${NODE_VERSION} AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package-related files first to leverage Docker's caching mechanism
COPY package.json package-lock.json* ./

# Install project dependencies using npm ci (ensures a clean, reproducible install)
# RUN --mount=type=cache,target=/root/.npm npm ci
RUN npm install 

# Copy the rest of the application source code into the container
COPY . .

# # Build the React.js application (outputs to /app/dist)
# RUN npm run build

# # =========================================
# # Stage 2: Prepare Nginx to Serve Static Files
# # =========================================

# FROM nginxinc/nginx-unprivileged:${NGINX_VERSION} AS runner

# # Copy custom Nginx config
# COPY nginx.conf /etc/nginx/nginx.conf

# # Copy the static build output from the build stage to Nginx's default HTML serving directory
# COPY --chown=nginx:nginx --from=builder /app/dist /usr/share/nginx/html

# # Use a built-in non-root user for security best practices
# USER nginx

# # Expose port 8080 to allow HTTP traffic
# # Note: The default NGINX container now listens on port 8080 instead of 80 
EXPOSE 8080

# # Start Nginx directly with custom config
# ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]
# CMD ["-g", "daemon off;"]

# Use $PORT so it works both locally and on Cloud Run
CMD ["sh", "-c", "serve -s dist -l ${PORT}"]

# # ---------- Build stage ----------
# FROM node:20-alpine AS builder

# WORKDIR /app

# # Install dependencies
# COPY package.json package-lock.json* ./
# RUN --mount=type=cache,target=/root/.npm npm install

# # Copy source and build
# COPY . .

# EXPOSE 5173

# # RUN npm run build
# CMD ["npm", "run", "dev"]