package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.domain.Author;
import net.croz.blog.blogweb.repository.AuthorUserRepository;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.Optional;

@Service
public class AuthorUserDetailsService implements UserDetailsService {
    @Autowired
    AuthorUserRepository authorUserRepository;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        Optional<Author> user = authorUserRepository.findByUserName(userName);

        user.orElseThrow(() -> new UsernameNotFoundException("Not found: " + userName));

        return user.map(AuthorUserDetails::new).get();
    }

    public String prepareRegistrationPage(Model model) {
        model.addAttribute("userForm", new Author());
        return "registration";
    }


    public String registerUser(Author author) {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        final String encryptedPassword = bCryptPasswordEncoder.encode(author.getPassword());
        author.setPassword(encryptedPassword);
        author.setActive(true);
        author.setRoles("ROLE_USER");
        authorUserRepository.save(author);

        return "redirect:/";
    }

    public Optional<Author> findByUserName(String username) {
        return authorUserRepository.findByUserName(username);
    }
}
