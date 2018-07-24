version: "3"
# Created by Joynal Abedin

services:
    redis:
      image: redis
    
    db:
      image: postgres:9.4
    
    vote:
      image: voting-app
      ports:
        - "5000:80"
      links:
        - redis
    
    result:
      image: result-app
      ports:
          - 5001:80
      links:
          - db
    
    worker:
      image: worker-app
      links:
      - redis
      - db

      *****************************************************************

version: '3'
services:
  
  redis:
    image: redis
    networks:
      - back-end
    volumes:
        - "redis-data:/var/lib/redis"

  db:
    image: postgres:9.4
    networks:
        - back-end
    volumes:
        - "db-data:/var/lib/postgresql/data"

  vote:
    image: voting-app
    ports:
      - "5000:80"
    networks:
        - back-end
        - front-end

  result:
    image: result-app
    ports:
        - 5001:80
    networks:
        - back-end
        - front-end

  worker:
    image: worker-app
    networks:
        - back-end

networks:
  front-end:
    driver: bridge
  back-end:
    driver: bridge

volumes:
  redis-data:
  db-data: