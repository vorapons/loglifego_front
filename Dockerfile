# ---------- Build stage ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm npm install

# Copy source and build
COPY . .

EXPOSE 5173

# RUN npm run build
CMD ["npm", "run", "dev"]