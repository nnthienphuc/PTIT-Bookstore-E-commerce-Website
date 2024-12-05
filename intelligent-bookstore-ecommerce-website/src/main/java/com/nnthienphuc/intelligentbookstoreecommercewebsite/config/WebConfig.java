package com.nnthienphuc.intelligentbookstoreecommercewebsite.config;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.interceptor.AuthorizeInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    // Define the AuthorizeInterceptor as a bean
    @Bean
    public AuthorizeInterceptor authorizeInterceptor() {
        return new AuthorizeInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authorizeInterceptor())  // Register the AuthorizeInterceptor
                .addPathPatterns("/user/cart") // Intercept paths that require authentication
                .excludePathPatterns("/user/account/login", "/user/account/register"); // Allow public paths
    }
}
