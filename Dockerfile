# To build:
# docker build --progress=plain -f Dockerfile .
#
# To run image:
# docker run -e NODE_ENV=production -p 3001:3001 <image_id>

FROM node:22-alpine AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /usr/src/app

# Install dependencies into temp directory
FROM base AS install

# Needed to install Prisma
RUN apk add --no-cache openssl

RUN mkdir -p /temp/dev
COPY schema /temp/dev/schema
COPY package.json pnpm-lock.yaml tsconfig.json /temp/dev/
RUN cd /temp/dev && pnpm i --frozen-lockfile

# Build the app
FROM oven/bun:1.2.19 AS build
WORKDIR /temp/build
COPY .env index.ts package.json /temp/build
COPY --from=install /temp/dev/generated generated
COPY --from=install /temp/dev/node_modules node_modules
RUN cd /temp/build && bun run build

# Copy built file to final image
FROM oven/bun:1.2.19 AS final
ARG PORT=8080
WORKDIR /usr/src/app

COPY --from=build /temp/build/.env .env
COPY --from=build /temp/build/repro repro

# Run the app
WORKDIR /usr/src/app
USER bun
EXPOSE ${PORT}/tcp
ENTRYPOINT [ "./repro" ]

# Healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f http://localhost:${PORT}/ || exit 1