package net.croz.blog.blogweb.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Qualifier("authorUserDetailsService")
    @Autowired
    UserDetailsService userDetailsService;

    /*
    @Bean
    protected UserDetailsService userDetailsService() {
        return super.userDetailsService();
    }*/

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                    .antMatchers("/resources/**", "/assets/**", "/registration", "/registrationProcessing")
                        .permitAll()
                        .anyRequest().authenticated()
                        .and()
                    .formLogin()
                    .loginPage("/login")
                    .loginProcessingUrl("/loginSecure")
                    .defaultSuccessUrl("/", true)
                    .permitAll()
                    .usernameParameter("username").passwordParameter("password")
                    .and()
                .csrf().disable()
                .logout()
                    .permitAll();
    }

    @Bean
    public PasswordEncoder getPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
