package com.clothes.perst;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class PerstApplication {
	public static void main(String[] args) {
		SpringApplication.run(PerstApplication.class, args);
	}

}
