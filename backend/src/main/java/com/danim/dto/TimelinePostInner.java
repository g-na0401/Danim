package com.danim.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TimelinePostInner {


    private String flag;
    private String nation;
    private List<MyPostDtoRes> postlist;

}
