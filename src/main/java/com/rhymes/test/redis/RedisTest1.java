package com.rhymes.test.redis;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RedisTest1 {
	
	@Autowired
	private PointRedisRepository pointRedisRepository;
	
	
	
	@RequestMapping("redistest1")
	public String re() {
		
		String id = "mhj";
		LocalDateTime rTime = LocalDateTime.of(2019, 9,23,0,0);
		Point point = Point.builder()
					.id(id)
					.amount(1000L)
					.refreshTime(rTime)
					.build();
		
		pointRedisRepository.save(point);
		
		Point savedPoint = pointRedisRepository.findById(id).get();
		System.out.println(savedPoint);
		
		
		return "";
	}
	
	
}
