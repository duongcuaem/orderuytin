package com.mrChill.Relax.Controller.USERs;


import javax.validation.Valid;

import com.mrChill.Relax.Dao.ItemDAO;
import com.mrChill.Relax.Repository.ItemRepository;
import com.mrChill.Relax.Service.ItemService;
import com.mrChill.Relax.Service.OrdersService;
import com.mrChill.Relax.Service.UsersService;
import com.mrChill.Relax.Utils.FileUtils;
import com.mrChill.Relax.entities.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user/item")
public class ItemControllerUser {
       @Autowired
	   ItemRepository ir;

       @Autowired
	   ItemService is;

	   @Autowired
	   UsersService us;

	   @Autowired
	   OrdersService os;

		@PostMapping("upload")
		@ResponseBody
		public String upload(@RequestParam("file") MultipartFile file)  throws Exception {
			return  FileUtils.saveFile(file);
		}

	@RequestMapping("cart")
	public String showItemCartList(Model model,@RequestParam(required = false, defaultValue ="Gio hang") String Status,
										  @RequestParam(required = false, defaultValue = "1") Integer page,
										  @RequestParam(required = false, defaultValue = "20") Integer perpage) {
		String userName = us.currentLoginUser().getUserName();
		Page<Item> pages =  is.showItemCartList(page,perpage,Status,userName);
		model.addAttribute("showItemCartList", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(us.currentLoginUser().getUserName()));
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
		return "user/item/cart";
	}
		@GetMapping(value="createItem")
		public String showCreateItemPage(Model model){
			String userName = us.currentLoginUser().getUserName();
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
			return "user/item/createItem";}

	@RequestMapping(value="create",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String save(@Valid @ModelAttribute ItemDAO itemDAO,
					   BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
					   RedirectAttributes model)  throws Exception {
		if(bindingResult.hasErrors()){
			return "user/item/createItem";
		}
		is.saveItem(itemDAO);
		if(itemDAO.getItemStatus().equals("Gio hang")){
		model.addFlashAttribute("message","Quý khách đã thêm hàng vào giỏ thành công , " +
				"hãy tiếp tục thêm hàng vào giỏ hoặc vào phần giỏ hàng để mua đơn hàng  !!!");}
		if(itemDAO.getItemStatus().equals("Cho xu ly")){
			model.addFlashAttribute("message","Quý khách đã đặt đơn hàng thành công , " +
					"hãy tiếp tục đặt đơn hàng mới hoặc vào phần đơn chờ xử lý để theo dõi đơn hàng  !!!");}
		String userName = us.currentLoginUser().getUserName();
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
		return "redirect:/user/item/createItem";
	}

	@RequestMapping(value="saveItemPending",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemPending(@Valid @ModelAttribute ItemDAO itemDAO,
								 BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
								 RedirectAttributes model)  throws Exception {
		if (bindingResult.hasErrors()) {
			return "user/item/cart";
		}

		//lưu order vào csdl
		is.handle(itemDAO);
		model.addFlashAttribute("message", "Đã gửi đơn hàng ,quý khách vui lòng chờ xử lý.");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(us.currentLoginUser().getUserName()));

		return "redirect:/user/item/cart";
	}

	@RequestMapping("updateCancel/{itemId}")
	public String updateCancel(Model model, @PathVariable Integer itemId) throws Exception{
		 is.updateCancel(itemId);
		model.addAttribute("message", "Đơn hàng đã bị hủy.");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(us.currentLoginUser().getUserName()));

		return "redirect:/user/item/cart";
	}

	@RequestMapping("save")
	public String save(Model model, @Valid @ModelAttribute ItemDAO itemDAO) throws Exception{
		is.save(itemDAO);
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItem", is.countCartItem(us.currentLoginUser().getUserName()));

		return "redirect:/user/order/arrivered";
	}

	@RequestMapping("updateEdit/{itemId}")
	public String updateEdit(Model model, @PathVariable Integer itemId) throws Exception{
		is.updateEdit(itemId);
		model.addAttribute("message", "Đơn hàng đã được sửa thành công.");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/user/item/cart";
	}



}
