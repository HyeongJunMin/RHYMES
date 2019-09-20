package com.rhymes.app.member.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings("serial")
@Getter
@Setter
@ToString
public class MemberDTO implements Serializable {
	
	private int seq;
	private String userid;
	private String userpw;
	
	private boolean isAccountNonExpired;
	private boolean isAccountNonLock;
	private boolean isCredentialsIsNonExpired;
	
	private boolean enabled;
	private List<AuthoritiesDTO> authList;
	private Date rdate;
	
	public MemberDTO() {}

	@Builder
	public MemberDTO(String userid, String userpw) {
		super();
		this.userid = userid;
		this.userpw = userpw;
	}

	@Builder
	public MemberDTO(String userid, String userpw, boolean enabled) {
		super();
		this.userid = userid;
		this.userpw = userpw;
		this.enabled = enabled;
	}	
	
	@Builder
	public MemberDTO(int seq, String userid, String userpw, boolean isAccountNonExpired, boolean isAccountNonLock,
			boolean isCredentialsIsNonExpired, boolean enabled, List<AuthoritiesDTO> authList, Date rdate) {
		super();
		this.seq = seq;
		this.userid = userid;
		this.userpw = userpw;
		this.isAccountNonExpired = isAccountNonExpired;
		this.isAccountNonLock = isAccountNonLock;
		this.isCredentialsIsNonExpired = isCredentialsIsNonExpired;
		this.enabled = enabled;
		this.authList = authList;
		this.rdate = rdate;
	}

}
/*
CREATE TABLE `rhy_mem` (
	`SEQ` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`ID` VARCHAR(1000) NOT NULL COMMENT '아이디',
	`PW` VARCHAR(1000) NOT NULL COMMENT '비밀번호',
	`isAccountNonExpired` VARCHAR(1000) NULL DEFAULT 'true' COMMENT '계정만료여부',
	`isAccountNonLock` VARCHAR(1000) NULL DEFAULT 'true' COMMENT '계정잠금여부',
	`isCredentialslsNonExpired` VARCHAR(1000) NULL DEFAULT 'true' COMMENT '자격만료여부',
	`isEnabled` VARCHAR(1000) NULL DEFAULT 'true' COMMENT '사용가능여부',
	`RDATE` DATETIME NOT NULL DEFAULT '',
	PRIMARY KEY (`SEQ`),
	UNIQUE INDEX `UNIQUE_ID` (`ID`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=2
;
*/
