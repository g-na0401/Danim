package com.danim.service;

import com.danim.entity.User;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    @Override
    public User insertUser(User user) {
        return userRepository.save(user);
    }
    @Override
    public void makeUser() {
        User u = new User();
        u.setClientId("22");
        userRepository.save(u);

    }
}