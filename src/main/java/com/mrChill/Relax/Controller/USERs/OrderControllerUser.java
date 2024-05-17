package com.mrChill.Relax.Controller.USERs;

import com.mrChill.Relax.Dao.OrdersDAO;
import com.mrChill.Relax.Repository.OrdersRepository;
import com.mrChill.Relax.Service.*;
import com.mrChill.Relax.entities.Item;
import com.mrChill.Relax.entities.Orders;
import com.mrChill.Relax.entities.WayBills;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/user/order")
public class OrderControllerUser {
	@Autowired
	OrdersService os;

	@Autowired
	MergedListService ms;

	@Autowired
	OrdersRepository or;

	@Autowired
	ItemService is;

	@Autowired
	UsersService us;

	@Autowired
	WayBillsService wbs;


	@RequestMapping(value="save",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String save(@Valid @ModelAttribute OrdersDAO ordersDAO,
					   BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
					   RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			return "redirect:/user/order/arrivered";
		}

		//lưu order vào csdl
		os.saveOrder(ordersDAO);
		if(ordersDAO.getOrderStatus().equals("Thanh cong")){
			model.addFlashAttribute("message", "Đơn hàng đã hoàn thành.Xin chúc mừng.");
			model.addAttribute("loginUser", us.currentLoginUser());
			model.addAttribute("countCartItem", is.countCartItem(us.currentLoginUser().getUserName()));

			return "redirect:/user/order/arrivered";
		}
		model.addFlashAttribute("message", "Gửi khiếu nại thành công");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/user/order/arrivered";
	}

	@RequestMapping("pending")
	public String showPendingListofClient(Model model,@RequestParam(required = false, defaultValue ="Cho xu ly") String Status,
									   @RequestParam(required = false, defaultValue = "1") Integer page,
									   @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		String userName = us.currentLoginUser().getUserName();
		Page<Item> pages =  is.showClientPendingList(page,perpage,Status,userName);
		model.addAttribute("showPendingListofClient", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));

		return "user/order/pending";
	}

	@GetMapping("detail/{orderNo}")
	public String showDetailOrderofClient(Model model,@PathVariable  String orderNo) {
		String userName = us.currentLoginUser().getUserName();
		Orders order =  os.showDetailByOrderNo(orderNo);
		model.addAttribute("sdoc", order);
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));
		return "user/order/detail";
	}

	@RequestMapping("bought")
	public String showBoughtOrderListofClient(Model model,
					   @RequestParam(required = false, defaultValue = "1") Integer page,
					   @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		String userName = us.currentLoginUser().getUserName();
		Page<Orders> pages =  os.showBoughtOrderListofClient(page,perpage);
		model.addAttribute("showBoughtOrderListofClient", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));

		return "user/order/bought";
	}

	@RequestMapping("deliveried")
	public String showDeliveriedOrderListofClient(Model model,
									  @RequestParam(required = false, defaultValue = "1") Integer page,
									  @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		String userName = us.currentLoginUser().getUserName();
		Page<Orders> pages =  os.showDeliveriedOrderListofClient(page,perpage);
		model.addAttribute("showDeliveriedOrderListofClient", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));
		return "user/order/deliveried";
	}

	@RequestMapping("arrivered")
	public String showArriveredOrderListofClient(Model model,
										  @RequestParam(required = false, defaultValue = "1") Integer page,
										  @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		String userName = us.currentLoginUser().getUserName();
		Page<Orders> pages =  os.showArriveredOrderListofClient(page,perpage);
		List<WayBills> showKGwaybillsList =  wbs.showKGwaybillsList();
		model.addAttribute("showKGwaybillsList", showKGwaybillsList);
		model.addAttribute("showArriveredOrderListofClient", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));

		return "user/order/arrivered";
	}


	@RequestMapping("complain")
	public String showComplainOrderList(Model model) {
		String userName = us.currentLoginUser().getUserName();
		model.addAttribute("showComplainOrderListfofClient", os.showComplainOrderListfofClient(userName));
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));

		return "user/order/complain";

	}
	@RequestMapping("finished")
	public String showFinishedOrderListofClient(Model model,
										 @RequestParam(required = false, defaultValue = "1") Integer page,
										 @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		String userName = us.currentLoginUser().getUserName();
		Page<Orders> pages =  os.showFinishedOrderListofClient(page,perpage);
		List<WayBills> showKGHTwaybillsList =  wbs.showKGHTwaybillsList();
		model.addAttribute("showKGHTwaybillsList", showKGHTwaybillsList);
		model.addAttribute("showFinishedOrderListofClient", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));

		return "user/order/finished";
	}
	@RequestMapping("cancel")
	public String showCancelOrderListofClient(Model model) {
		String userName = us.currentLoginUser().getUserName();
		model.addAttribute("showCancelOrderListofClient", os.showCancelOrderListofClient());
		model.addAttribute("showCancelItemListofClient", is.showItemListofClient(userName));
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));

		return "user/order/cancel";
	}

	@RequestMapping("whole")
	public String showWholeOrderListofClient(Model model,
									  @RequestParam(required = false, defaultValue = "1") Integer page,
									  @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		String userName = us.currentLoginUser().getUserName();
		Page<Orders> pages =  os.showWholeOrderListofClient(page,perpage);
		model.addAttribute("showWholeOrderListofClient", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(userName));
		model.addAttribute("countPendingOrder",is.countPendingItem(userName));
		model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
		model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
		model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
		model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
		model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
		model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
		model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
		model.addAttribute("countCancelItem",is.countCancelItem(userName));

		return "user/order/whole";
	}


}
