package com.appdynamics.demo;

import java.util.concurrent.atomic.AtomicLong;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpEntity;
import org.springframework.ui.Model;


@RestController
public class GreetingController {

	private static final String template = "Hello, %s!";
	private final AtomicLong counter = new AtomicLong();

	@GetMapping("/home")
	public Greeting greeting(@RequestParam(value = "name", defaultValue = "AppD WinContainer Solution") String name) {
		return new Greeting(counter.incrementAndGet(), String.format(template, name));
    }
    
    @GetMapping("/product")
	public Greeting pay(@RequestParam(value = "name", defaultValue = "Hello AppD") String name) {
		return new Greeting(counter.incrementAndGet(), String.format(template, name));
    }

    @GetMapping("/checkout")
	public Greeting checkout(@RequestParam(value = "name", defaultValue = "World") String name) {
		return new Greeting(counter.incrementAndGet(), String.format(template, name));
    }

    @RequestMapping(value = "/basket")
    public String hello(Model model) {
        model.addAttribute("message", "Hello from the controller");

    final String uri = "http://www.example.com";
     
    RestTemplate restTemplate = new RestTemplate();
    String result = restTemplate.getForObject(uri, String.class);
    
     return result;
    }
    
    @RequestMapping(value = "/supplier")
    public String saynaomi(Model model) {
        model.addAttribute("message", "Say Naomi");

    final String uri = "http://front-end";
     
    RestTemplate restTemplate = new RestTemplate();
    String result = restTemplate.getForObject(uri, String.class);
    
     return result;
    }


}