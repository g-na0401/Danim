package com.danim.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;


//사용할 ErrorMessage를 정의하는곳, 개발자가 정의하여 추가해면 됨
@Getter
public enum ErrorMessage {
    VALIDATION_FAIL_EXCEPTION(-1, "입력 값의 조건이 잘못 되었습니다.", HttpStatus.BAD_REQUEST),
    UNDEFINED_EXCEPTION(0, "정의되지 않은 에러입니다.", HttpStatus.INTERNAL_SERVER_ERROR),
    BINDING_FAIL_EXCEPTION(1, "내부 서버에서 오류가 발생하였습니다.", HttpStatus.INTERNAL_SERVER_ERROR),

    NOT_PERMISSION_EXCEPTION(5, "권한이 없거나 부족합니다.", HttpStatus.FORBIDDEN),
    NOT_EXIST_ROUTE(6, "존재하지 않는 경로입니다.", HttpStatus.BAD_REQUEST),

    NOT_EXIST_USER(7,"존재하지 않는 유저 입니다",HttpStatus.BAD_REQUEST);



    private final Integer code;
    private final String errMsg;
    private final HttpStatus httpStatus;

    ErrorMessage(int code, String errMsg, HttpStatus httpStatus) {
        this.code = code;
        this.errMsg = errMsg;
        this.httpStatus = httpStatus;
    }


}
