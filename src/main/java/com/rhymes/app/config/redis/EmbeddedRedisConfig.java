package com.rhymes.app.config.redis;

import java.io.IOError;
import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;


import lombok.extern.slf4j.Slf4j;
import redis.embedded.RedisServer;

/**내장 Redis를 프로젝트가 profile=local일때만 실행되도록 하는 설정
 * @author minhj
 *
 */
@Slf4j
@Profile("local")//profile이 local일때만 활성화
@Configuration
public class EmbeddedRedisConfig {

		@Value("${spring.redis.port}")
		private int redisPort;
		
		private RedisServer redisServer;
		
		@PostConstruct
		public void redisServer() throws IOException{
			log.info("redis server has been started");
			redisServer = new RedisServer(redisPort);
			redisServer.start();
		}
		
		@PreDestroy
		public void stopRedis() {
			log.info("stop redis server");
			if( redisServer != null ) {
				redisServer.stop();
			}
		}
	
}
