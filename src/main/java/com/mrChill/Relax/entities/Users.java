package com.mrChill.Relax.entities;
import java.util.*;
import javax.persistence.*;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;


@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "users")
public class Users extends EntityBase {
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	@Column(name = "userId")
	public Integer userId;

	@Basic
	@Column(name = "userName")
	public String userName;

	@Basic
	@Column(name = "rate")
	public Integer rate ;

	@Basic
	@Column(name = "rateKg")
	public Integer rateKg ;

	@Basic
	@Column(name = "rateM3")
	public Integer rateM3 ;

	@Basic
	@Column(name = "address")
	public String address;

	@Basic
	@Column(name = "phone")
	public String phone;

	@Basic
	@Column(name = "role")
	public String role;

	@Basic
	@Column(name = "email")
	public String email;

	@Basic
	@Column(name = "password")
	public String password;
	
    @Basic
    @Column(name = "rePassword")
	public String rePassword;

	@Basic
	@Column(name = "STATUS")
	public Integer STATUS;

	@OneToMany(mappedBy = "userId")
	public List<ChargMoney> chargMoneyList;


//	@ManyToMany
//	@JoinTable(name="users_role",
//	joinColumns = @JoinColumn(name="Users_Id"),
//	inverseJoinColumns = @JoinColumn(name="Roles_ID"))
//	private Set<Role> roles = new HashSet<>();

//	@Override
//	public Collection<? extends GrantedAuthority> getAuthorities() {
//		Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
//		roles.stream().forEach(i->authorities.add(new SimpleGrantedAuthority(i.getName())));
//		return List.of(new SimpleGrantedAuthority(authorities.toString()));
//
//	}

//	@Override
//	public String getUsername() {
//		return phone;
//	}
//
//	@Override
//	public String getPassword() {
//		return password;
//	}
//
//	@Override
//	public boolean isAccountNonExpired() {
//		return true;
//	}
//
//	@Override
//	public boolean isAccountNonLocked() {
//		return true;
//	}
//
//	@Override
//	public boolean isCredentialsNonExpired() {
//		return true;
//	}
//
//	@Override
//	public boolean isEnabled() {
//		return true;
//	}
}
