# Stage 1: Build the application
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Stage 2: Run the application
FROM node:18-alpine

WORKDIR /app

COPY --from=build /app .

# Create a non-root user
RUN addgroup --gid 1001 appgroup \
    && adduser --uid 1001 --ingroup appgroup --disabled-password --gecos "" appuser

USER appuser

# Environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Expose the application port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f http://localhost:$PORT/ || exit 1

CMD ["node", "index.js"] 