package com.model;

// Generated Jul 17, 2016 12:17:38 PM by Hibernate Tools 3.4.0.CR1

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Zone generated by hbm2java
 */
@Entity
@Table(name = "zone")
public class Zone implements java.io.Serializable {

	private Integer id;
	private String name;
	private String desc;
	private Set<UserInfo> userInfos = new HashSet<UserInfo>(0);
	private Set<UserInfo> userInfos_1 = new HashSet<UserInfo>(0);

	public Zone() {
	}

	public Zone(String name) {
		this.name = name;
	}

	public Zone(String name, String desc, Set<UserInfo> userInfos,
			Set<UserInfo> userInfos_1) {
		this.name = name;
		this.desc = desc;
		this.userInfos = userInfos;
		this.userInfos_1 = userInfos_1;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", nullable = false, length = 45)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "desc", length = 500)
	public String getDesc() {
		return this.desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "zone")
	public Set<UserInfo> getUserInfos() {
		return this.userInfos;
	}

	public void setUserInfos(Set<UserInfo> userInfos) {
		this.userInfos = userInfos;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "zone")
	public Set<UserInfo> getUserInfos_1() {
		return this.userInfos_1;
	}

	public void setUserInfos_1(Set<UserInfo> userInfos_1) {
		this.userInfos_1 = userInfos_1;
	}

}
