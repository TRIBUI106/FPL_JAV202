package chez1s.assignment.service;

import chez1s.assignment.entity.User;
import chez1s.assignment.repository.UserRepository;

public class AuthService {
    private final UserRepository userRepository;

    public AuthService() {
        this.userRepository = new UserRepository();
    }

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User login(String email, String password) {
        User user = userRepository.findByEmail(email);
        if (user != null && user.isActive() && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
