package com.mrChill.Relax.Controller.ADMIN;

import com.mrChill.Relax.Dao.ItemDAO;
import com.mrChill.Relax.Dao.OrdersDAO;
import com.mrChill.Relax.Repository.OrdersRepository;
import com.mrChill.Relax.Service.*;
import com.mrChill.Relax.entities.Item;
import com.mrChill.Relax.entities.MergedList;
import com.mrChill.Relax.entities.Orders;
import com.mrChill.Relax.entities.WayBills;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/backend/order")
public class OrderController{
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

	@GetMapping("detail/{orderId}")
	public String showDetailOrderofClient(Model model,@PathVariable  Integer orderId) {
		String userName = us.currentLoginUser().getUserName();
		Orders order =  os.showDetailByOrderNo(or.findOrdersByOrderId(orderId).orderNo);
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
		return "backend/order/detail";
	}

	@RequestMapping(value="insertSingleOrder",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
		public String insertSingleOrder(@Valid @ModelAttribute OrdersDAO ordersDAO, ItemDAO itemDAO,
						   BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
                           RedirectAttributes model)  throws Exception {
			if(bindingResult.hasErrors()){
				return "backend/order/pending";
			}

			//lưu order vào csdl
			os.insertSingleOrder(ordersDAO,itemDAO);
		    model.addAttribute("loginUser", us.currentLoginUser());
			model.addFlashAttribute("message","处理成功.");
			return "redirect:/backend/order/pending" ;
		}

	@RequestMapping(value="insertMultiOrder",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String insertMultiOrder(@Valid @ModelAttribute OrdersDAO ordersDAO,
									BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
									RedirectAttributes model)  throws Exception {
		if(bindingResult.hasErrors()){
			model.addFlashAttribute("message","处理失败.");
			return "redirect:/backend/order/pending";
		}

		//lưu order vào csdl
		MergedList ml = new MergedList();
		ml.setItems(new ArrayList<>(ms.getAllItem()));
		os.insertMultiOrder(ordersDAO,ml);
		if(ordersDAO.getOrderStatus().equals("Sua don")){
			return "redirect:/backend/order/fix" ;
		}
		model.addFlashAttribute("message","处理成功.");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/pending" ;
	}

	@RequestMapping(value="save",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String save(@Valid @ModelAttribute OrdersDAO ordersDAO,
									BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
									RedirectAttributes model)  throws Exception {
		if (ordersDAO.getOrderStatus().equals("Da phat hang")) {
			if (bindingResult.hasErrors()) {
				return "backend/order/deliveried";
			}

			//lưu order vào csdl
			 os.saveOrder(ordersDAO);
			model.addFlashAttribute("message", "订单更新成功.");
			model.addAttribute("loginUser", us.currentLoginUser());

			return "redirect:/backend/order/deliveried";
		}
		if (bindingResult.hasErrors()) {
			return "backend/order/arrivered";
		}

		//lưu order vào csdl
		 os.saveOrder(ordersDAO);
		model.addFlashAttribute("message", "订单更新成功.");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/arrivered";
		}

	@RequestMapping("editStatus/{orderId}")
	public String editStatus(RedirectAttributes model, @PathVariable Integer orderId) throws Exception{
		os.editStatus(orderId);
		model.addFlashAttribute("message", "更新订单成功.");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/arrivered";
	}


	@RequestMapping(value="saveFix",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveFix(@Valid @ModelAttribute OrdersDAO ordersDAO,
					   BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
					   RedirectAttributes model)  throws Exception {
		if (bindingResult.hasErrors()) {
			return "backend/order/fix";
		}
		if (ordersDAO.getOrderStatus().equals("Da phat hang")||ordersDAO.getOrderStatus().equals("Thanh cong")) {
			os.saveOrder(ordersDAO);
			model.addFlashAttribute("message", "订单更新成功.");
			return "redirect:/backend/order/complain";
		}
		//lưu order vào csdl
		 os.saveOrder(ordersDAO);
		model.addFlashAttribute("message", "订单更新成功.");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/pending";
	}

	@RequestMapping(value="saveOrderCancel",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveOrderCancel(@Valid @ModelAttribute OrdersDAO orderDAO,
								 BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
								 RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			return "backend/order/cancel";
		}

		if(orderDAO.getOrderStatus().equals("Da mua hang")){
			//lưu order vào csdl
			os.saveOrder(orderDAO);
			model.addFlashAttribute("message", "订单恢复成功.");
			model.addAttribute("loginUser", us.currentLoginUser());

			return "redirect:/backend/order/cancel";
		}
		List<Item> listItems = is.showItemByOrderId(orderDAO.orderId);
		List<WayBills> listWayBills = wbs.showWayBillsByOrderId(orderDAO.orderId);
		for (Item item: listItems) {
			is.remove(item);
		}
		for (WayBills wb: listWayBills) {
			wbs.remove(wb);
		}
		os.remove(orderDAO.convertToEntity());
		model.addFlashAttribute("message", "订单已删除 .");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/cancel";
	}
	@RequestMapping("restore")
	public String restore(RedirectAttributes model,OrdersDAO ordersDAO) throws Exception{
		os.saveOrder(ordersDAO);
		model.addFlashAttribute("message", "订单恢复成功.");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/cancel";
	}

	@RequestMapping("fix")
	public String showFixOrder(Model model) {
		 List<Orders> orders =  os.showFixOrder();
		model.addAttribute("showFixOrder", orders);
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
		return "backend/order/fix";
	}

	@RequestMapping("pending")
	public String showPendingOrderList(Model model, @RequestParam(required = false, defaultValue ="Cho xu ly") String searchKey,
									   @RequestParam(required = false, defaultValue = "1") Integer page,
									   @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		Page<Item> pages =  is.list(page,perpage,searchKey);
		model.addAttribute("showPendingOrderList", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());

		return "backend/order/pending";
	}

	@RequestMapping("bought")
	public String showBoughtOrderList(Model model,
					   @RequestParam(required = false, defaultValue = "1") Integer page,
					   @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		Page<Orders> pages =  os.showBoughtOrderList(page,perpage);
		model.addAttribute("showBoughtOrderList", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
		return "backend/order/bought";
	}
	@RequestMapping("deliveried")
	public String showDeliveriedOrderList(Model model,
									  @RequestParam(required = false, defaultValue = "1") Integer page,
									  @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		Page<Orders> pages =  os.showDeliveriedOrderList(page,perpage);
		model.addAttribute("showDeliveriedOrderList", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());

		return "backend/order/deliveried";
	}

	@RequestMapping("arrivered")
	public String showArriveredOrderList(Model model,
										  @RequestParam(required = false, defaultValue = "1") Integer page,
										  @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		Page<Orders> pages =  os.showArriveredOrderList(page,perpage);
		List<WayBills> showKGwaybillsListofAdMin =  wbs.showKGwaybillsListofAdMin();
		model.addAttribute("showKGwaybillsListofAdMin", showKGwaybillsListofAdMin);
		model.addAttribute("showArriveredOrderList", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());

		return "backend/order/arrivered";
	}

	@RequestMapping("finished")
	public String showFinishedOrderList(Model model,
										@RequestParam(required = false, defaultValue = "1") Integer page,
										@RequestParam(required = false, defaultValue = "100") Integer perpage) {
		Page<Orders> pages =  os.showFinishedOrderList(page,perpage);
		List<WayBills> showKGHTwaybillsListofAdMin =  wbs.showKGHTwaybillsListofAdMin();
		model.addAttribute("showKGHTwaybillsListofAdMin", showKGHTwaybillsListofAdMin);
		model.addAttribute("showFinishedOrderList", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());

		return "backend/order/finished";
	}

	@RequestMapping("complain")
	public String showComplainOrderList(Model model, @RequestParam(required = false, defaultValue ="Khieu nai") String searchKey) {
		List<Item> showComplainItemList =  is.showItemList(searchKey);
		List<Orders> showComplainOrderList =  os.showComplainOrderList(searchKey);
		model.addAttribute("showComplainItemList", showComplainItemList);
		model.addAttribute("showComplainOrderList", showComplainOrderList);
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());

		return "backend/order/complain";
	}

	@RequestMapping("cancel")
	public String showCancelOrderList(Model model, @RequestParam(required = false, defaultValue ="Huy") String searchKey) {
		List<Orders> listOrder =  os.showCancelOrderList();
		List<Item> listItem =  is.showItemList(searchKey);
		model.addAttribute("showCancelOrderList", listOrder);
		model.addAttribute("showCancelItemList", listItem);
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());


		return "backend/order/cancel";
	}

	@RequestMapping("whole")
	public String showWholeOrderList(Model model,
									  @RequestParam(required = false, defaultValue = "1") Integer page,
									  @RequestParam(required = false, defaultValue = "200") Integer perpage) {
		Page<Orders> pages =  os.showWholeOrderList(page,perpage);
		model.addAttribute("showWholeOrderList", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());

		return "backend/order/whole";
	}


}
