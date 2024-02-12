# Stage 1: Construye la aplicación React
FROM node:18 as builder

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Configura Nginx y copia los archivos construidos
FROM nginx:alpine

COPY --from=builder /app/dist /var/www/app/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

