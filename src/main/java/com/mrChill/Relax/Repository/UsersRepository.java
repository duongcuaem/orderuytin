package com.mrChill.Relax.Repository;

import com.mrChill.Relax.Dto.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mrChill.Relax.entities.Users;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface UsersRepository extends JpaRepository <Users,Integer> {

	Users findFirstByPhone(String phone);

	Users findByUserId(Integer id);
	boolean existsByEmail (String email);
	boolean existsByPhone (String phone);
	List<Users> findByRoleNotContainsIgnoreCase(String character);
	Users findByUserNameIsContainingIgnoreCase(String character);

	Users findByPhoneIsContainingIgnoreCase(String character);

	Users findUsersByEmail(String email);

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto" +
			"(u.userId,u.userName ) " +
			"FROM Users u WHERE u.role='ROLE_USER' "
			)
	List<UserDto> sumTotal();

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto0" +
			"(u.userId,u.userName,sum(o.totalVN) ) " +
			"FROM Users u " +
			"JOIN Orders o ON o.orderUserName = u.userName " +
			"WHERE u.role='ROLE_USER' "+
			"GROUP BY u.userId, u.userName " )
	List<UserDto0> sumTotal0();

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto00" +
			"(u.userId,u.userName,sum(CASE WHEN (o.orderStatus='Huy') THEN o.totalVN ELSE 0 END) ) " +
			"FROM Users u " +
			"JOIN Orders o ON o.orderUserName = u.userName " +
			"WHERE u.role='ROLE_USER' "+
			"GROUP BY u.userId, u.userName " )
	List<UserDto00> sumTotal00();

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto1" +
			"(u.userId,u.userName,sum(i.quantityRefund*i.price*i.CNYrateVND) ) " +
			"FROM Users u " +
			"JOIN Item i ON i.itemUserName = u.userName " +
			"WHERE u.role='ROLE_USER' "+
			"GROUP BY u.userId, u.userName " )
	List<UserDto1> sumTotal1();

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto2" +
			"(u.userId, u.userName,sum(cm.amount) ) "+
			"FROM Users u " +
			"JOIN ChargMoney cm ON cm.userId = u.userId " +
			"WHERE u.role='ROLE_USER' "+
			"GROUP BY u.userId, u.userName " )
	List<UserDto2> sumTotal2();

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto3" +
			"(u.userId, u.userName,sum(wb.freight) ) "+
			"FROM Users u " +
			"JOIN WayBills wb ON wb.wbUserName = u.userName " +
			"WHERE u.role='ROLE_USER' "+
			"GROUP BY u.userId, u.userName" )
	List<UserDto3> sumTotal3();


	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto" +
			"(u.userId, u.userName )" +
			"FROM Users u " +
			"WHERE u.userName = ?1 AND u.role='ROLE_USER' ")
	UserDto sumTotalUser(String userName);

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto0" +
			"(u.userId, u.userName,sum(o.totalVN)) " +
			"FROM Users u " +
			"JOIN Orders o  ON o.orderUserName = u.userName " +
			"WHERE u.userName = ?1 AND u.role='ROLE_USER' " +
			"GROUP BY u.userId, u.userName")
	UserDto0 sumTotalUser0(String userName);

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto00" +
			"(u.userId, u.userName,sum(CASE WHEN (o.orderStatus='Huy') THEN o.totalVN ELSE 0 END) ) " +
			"FROM Users u " +
			"JOIN Orders o  ON o.orderUserName = u.userName " +
			"WHERE u.userName = ?1 AND u.role='ROLE_USER' " +
			"GROUP BY u.userId, u.userName")
	UserDto00 sumTotalUser00(String userName);

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto1" +
			"(u.userId, u.userName,sum(i.quantityRefund*i.price*i.CNYrateVND)) " +
			"FROM Users u " +
			"JOIN Item i  ON i.itemUserName = u.userName " +
			"WHERE u.userName = ?1 AND u.role='ROLE_USER' " +
			"GROUP BY u.userId, u.userName " )
	UserDto1 sumTotalUser1(String userName);

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto2" +
			"(u.userId, u.userName,sum(cm.amount) ) "+
			"FROM Users u " +
			"JOIN ChargMoney cm ON cm.userId = u.userId " +
			"WHERE u.userName = ?1 AND u.role='ROLE_USER' " +
			"GROUP BY u.userId, u.userName " )
	UserDto2 sumTotalUser2(String userName);

	@Query(value = "SELECT new com.mrChill.Relax.Dto.UserDto3" +
			"(u.userId, u.userName,sum(wb.freight) ) "+
			"FROM Users u " +
			"JOIN WayBills wb ON wb.wbUserName = u.userName " +
			"WHERE u.userName = ?1 AND u.role='ROLE_USER' " +
			"GROUP BY u.userId, u.userName " )
	UserDto3 sumTotalUser3(String userName);

}
