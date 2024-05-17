package com.mrChill.Relax.Service;

import com.mrChill.Relax.Dao.UsersDAO;
import com.mrChill.Relax.Dto.*;
import com.mrChill.Relax.Repository.UsersRepository;
import com.mrChill.Relax.config.language.MessageConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mrChill.Relax.entities.Users;

import java.util.List;

@Service
@Transactional
public class UsersService {

	@Autowired
	UsersRepository ur;

	@Autowired
	MessageConfig mess;

	@Autowired
	PasswordEncoder passwordEncoder;


	public Users currentLoginUser() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = authentication.getName();
		return ur.findFirstByPhone(principalName);
	}

	public void save(UsersDAO usersDAO) {
		Users user = usersDAO.convertToEntity();
		 ur.save(user);
	}

	public void savePassword(UsersDAO usersDAO) {
		Users user = usersDAO.convertToEntity();
		user.setPassword(passwordEncoder.encode(usersDAO.getPassword()));
		user.setRePassword(passwordEncoder.encode(usersDAO.getRePassword()));
		ur.save(user);
	}
	public void createUser(UsersDAO usersDAO){
		Users user = usersDAO.convertToEntity();
		user.setPassword(passwordEncoder.encode(usersDAO.getPassword()));
		user.setRePassword(passwordEncoder.encode(usersDAO.getRePassword()));
		ur.save(user);
	}

	 public void delete(Integer id){
	        Users userEntity = ur.findById(id).get();
	        if(userEntity== null) {}
	        ur.deleteById(id);
	    }

	public List<Users>  list (){
		return ur.findByRoleNotContainsIgnoreCase("ROLE_ADMIN"); }

	public List<UserDto> sumTotal (){
		List<UserDto3> listWayBills = ur.sumTotal3();
		List<UserDto2> listCharg = ur.sumTotal2();
		List<UserDto1> listRefundVN = ur.sumTotal1();
		List<UserDto0> listTotalVN = ur.sumTotal0();
		List<UserDto00> listTotalCancelVN = ur.sumTotal00();
		
		List<UserDto> listUser = ur.sumTotal();
		for (UserDto u: listUser) {
			UserDto0 userDto0 = listTotalVN.stream().filter(x -> x.getUserId().equals(u.getUserId())).findFirst().orElse(null);
			UserDto00 userDto00 = listTotalCancelVN.stream().filter(x -> x.getUserId().equals(u.getUserId())).findFirst().orElse(null);
			UserDto1 userDto1 = listRefundVN.stream().filter(x -> x.getUserId().equals(u.getUserId())).findFirst().orElse(null);
			UserDto2 userDto2 = listCharg.stream().filter(x -> x.getUserId().equals(u.getUserId())).findFirst().orElse(null);
			UserDto3 userDto3 = listWayBills.stream().filter(x -> x.getUserId().equals(u.getUserId())).findFirst().orElse(null);

			if (userDto0 == null){
				u.setTotalVN((double) 0);
			}

			if (userDto00 == null){
				u.setTotalCancelVN((double) 0);
			}

			if (userDto1 == null){
				u.setTotalReFundVN((double) 0);
			}

			if (userDto2== null){
				u.setTotalAmount((double) 0);
			}

			if (userDto3 == null){
				u.setTotalFreight((double) 0);
			}

			if (userDto0 != null){
				u.setTotalVN(userDto0.getTotalVN());
			}

			if (userDto00!= null){
				u.setTotalCancelVN(userDto00.getTotalCancelVN());
			}

			if (userDto1 != null){
				u.setTotalReFundVN(userDto1.getTotalReFundVN());
			}

			if (userDto2 != null){
				u.setTotalAmount(userDto2.getTotalAmount());
			}

			if (userDto3!= null){
				u.setTotalFreight(userDto3.getTotalFreight());
			}

		}
		return listUser;
	}


	public UserDto searchTotalUser (String character){
		Users User = ur.findByUserNameIsContainingIgnoreCase(character);

		UserDto userDto = ur.sumTotalUser(User.getUserName());

		UserDto0 TotalVN = ur.sumTotalUser0(User.getUserName());
		UserDto00 TotalCancelVN = ur.sumTotalUser00(User.getUserName());
		UserDto1 Refund = ur.sumTotalUser1(User.getUserName());
		UserDto2 Charg = ur.sumTotalUser2(User.getUserName());
		UserDto3 WayBills = ur.sumTotalUser3(User.getUserName());

		if(TotalVN == null) {userDto.setTotalVN((double) 0);}
		if(TotalVN != null) {userDto.setTotalVN(TotalVN.getTotalVN());}

		if(TotalCancelVN == null){userDto.setTotalCancelVN((double) 0);}
		if(TotalCancelVN != null){userDto.setTotalCancelVN(TotalCancelVN.getTotalCancelVN());}

		if(Refund == null) {userDto.setTotalReFundVN((double) 0);}
		if(Refund != null) {userDto.setTotalReFundVN(Refund.getTotalReFundVN());}

		if(Charg == null) {userDto.setTotalAmount((double) 0);}
		if(Charg != null) {userDto.setTotalAmount(Charg.getTotalAmount());}

		if(WayBills == null) {userDto.setTotalFreight((double) 0);}
		if(WayBills != null){userDto.setTotalFreight(WayBills.getTotalFreight());}

		return userDto;
	}

	public Users searchInfoUser (String character){
		Users User = ur.findByUserNameIsContainingIgnoreCase(character);
		return User;
	}

	public Users searchByPhone (String character){
		return ur.findByPhoneIsContainingIgnoreCase(character);
	}
	public Users changPass (Integer id){
		Users User = ur.findByUserId(id);
		return User;
	}

}
