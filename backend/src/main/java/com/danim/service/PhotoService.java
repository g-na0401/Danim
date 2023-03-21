package com.danim.service;

import com.danim.entity.Photo;
import com.danim.entity.Post;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface PhotoService {
    Photo createPhoto(Double lat, Double lng, MultipartFile imageFile, Post savedPost) throws Exception;
}
