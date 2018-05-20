package egovframework.com.cmm.message;

public enum ResultStatus {

	/**
	 * {@code 200 성공했습니다.}.
	 * @see 
	 */
	OK(200, "성공했습니다."),
	FAIL(500, "실패했습니다."),	
	IGNORE(210,"무시"),
	STATUS_USER_NOT_ID( 11, "사용자가 아이디가 존재하지 않습니다."),
    STATUS_USER_NOT_PASSWORD( 12, "비밀번호 없음"),
	STATUS_NOT_MATCH( 13, "비밀번호가 맞지 않을 때"),
	STATUS_NOT_INPUT( 14, "비밀번호가 입력되지 않았을 때"),
	STATUS_NOT_VALIDATE( 15, "비밀번호가 유효하지 않을 때"),
	STATUS_FIRST_VISIT(16, " 최초접속시 비밀번호 변경");
	
	private final int value;

	private final String reasonPhrase;


	private ResultStatus(int value, String reasonPhrase) {
		this.value = value;
		this.reasonPhrase = reasonPhrase;
	}

	/**
	 * Return the integer value of this status code.
	 */
	public int value() {
		return this.value;
	}

	/**
	 * Return the reason phrase of this status code.
	 */
	public String getReasonPhrase() {
		return reasonPhrase;
	}

	/**
	 * Return a string representation of this status code.
	 */
	@Override
	public String toString() {
		return Integer.toString(value);
	}


	/**
	 * Return the enum constant of this type with the specified numeric value.
	 * @param statusCode the numeric value of the enum to be returned
	 * @return the enum constant with the specified numeric value
	 * @throws IllegalArgumentException if this enum has no constant for the specified numeric value
	 */
	public static ResultStatus valueOf(int statusCode) {
		for (ResultStatus status : values()) {
			if (status.value == statusCode) {
				return status;
			}
		}
		throw new IllegalArgumentException("No matching constant for [" + statusCode + "]");
	}

	
	

}
