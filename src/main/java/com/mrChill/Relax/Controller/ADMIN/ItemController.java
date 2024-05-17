package com.mrChill.Relax.Controller.ADMIN;


import com.mrChill.Relax.Dao.ItemDAO;
import com.mrChill.Relax.Dao.OrdersDAO;
import com.mrChill.Relax.Repository.ItemRepository;
import com.mrChill.Relax.Service.ItemService;
import com.mrChill.Relax.Service.OrdersService;
import com.mrChill.Relax.Service.UsersService;
import com.mrChill.Relax.Utils.FileUtils;
import com.mrChill.Relax.entities.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping("/backend/item")
@PreAuthorize("hasRole('ADMIN')")
public class ItemController {
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
	@GetMapping(value="createItem")
	public String showCreateItemPage(Model model){
			model.addAttribute("listUser", us.list());
			model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
		return "backend/item/createItem";}

	@GetMapping("detail/{itemId}")
	public String detail(@PathVariable Integer itemId,Model model){
		model.addAttribute("item", is.findByItemId(itemId));
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
		return "backend/item/detail";}
	@RequestMapping("cart")
	public String showItemCartList(Model model,@RequestParam(required = false, defaultValue ="Gio hang") String Status,
								   @RequestParam(required = false, defaultValue = "1") Integer page,
								   @RequestParam(required = false, defaultValue = "100") Integer perpage) {
		Page<Item> pages =  is.showItemCartAdminList(page,perpage,Status);
		model.addAttribute("showItemCartAdminList", pages.getContent());
		model.addAttribute("page", page);
		model.addAttribute("perpage", perpage);
		model.addAttribute("total", pages.getTotalPages());
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());
		model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
		model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
		model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
		model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
		model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
		model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
		model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
		model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
		model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
		return "backend/item/cart";
	}

	@RequestMapping(value="create",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String save(@Valid @ModelAttribute ItemDAO itemDAO,
					   BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
					   RedirectAttributes model)  throws Exception {
		if(bindingResult.hasErrors()){
			model.addFlashAttribute("message","加货失败,请再造作.");
			return "backend/item/createItem";
		}
		is.saveItem(itemDAO);
		model.addFlashAttribute("message","加货成功 !!!");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/item/createItem";
	}

	@RequestMapping(value="saveItemArrivered",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemArrivered(@Valid @ModelAttribute ItemDAO itemDAO,
					   BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
					   RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			return "backend/order/arrivered";
		}

		//lưu order vào csdl
	      is.save(itemDAO);
		model.addFlashAttribute("message", "更新订单成功..");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/order/arrivered";
	}

	@RequestMapping(value="saveItem",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItem(@Valid @ModelAttribute ItemDAO itemDAO,
									BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
									RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			return "backend/item/detail";
		}

		//lưu order vào csdl
		is.saveItem(itemDAO);
		model.addFlashAttribute("message", "更新订单成功..");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/pending";
	}

	@RequestMapping(value="saveItemCart",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemCart(@Valid @ModelAttribute ItemDAO itemDAO,
								  BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
								  RedirectAttributes model)  throws Exception {
		if (bindingResult.hasErrors()) {
			return "backend/item/cart";
		}

		//lưu order vào csdl
		is.handle(itemDAO);
		model.addFlashAttribute("message", "更新订单成功..");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/item/cart";
	}

	@RequestMapping(value="saveItemBought",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemBought(@Valid @ModelAttribute ItemDAO itemDAO,
									BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
									RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			return "backend/order/bought";
		}

		//lưu order vào csdl
		 is.save(itemDAO);
		model.addFlashAttribute("message", "更新订单成功.");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/order/bought";
	}

	@RequestMapping("updateCancel/{itemId}")
	public String updateCancel(RedirectAttributes model, @PathVariable Integer itemId) throws Exception{
		is.updateCancel(itemId);
		model.addFlashAttribute("message", "订单已取消.");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/pending";
	}

	@RequestMapping("updateRestore/{itemId}")
	public String updateRestore(RedirectAttributes model, @PathVariable Integer itemId) throws Exception{
		is.updateRestore(itemId);
		model.addFlashAttribute("message", "订单已恢复.");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/pending";
	}

	@RequestMapping("updateEdit/{itemId}")
	public String updateEdit(Model model, @PathVariable Integer itemId) throws Exception{
		is.updateEdit(itemId);
		model.addAttribute("message", "修改订单成功.");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/order/item/cart";
	}

	@RequestMapping(value="saveItemDeliveried",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemDeliveried(@Valid @ModelAttribute ItemDAO itemDAO,
									BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
									RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());
			return "backend/order/deliveried";
		}

		//lưu order vào csdl
		 is.save(itemDAO);
		model.addFlashAttribute("message", "Cập nhật đơn hàng thành công.");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/order/deliveried";
	}
	@RequestMapping(value="saveItemFinished",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemFinished(@Valid @ModelAttribute ItemDAO itemDAO,
								 BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
								 RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			return "backend/order/finished";
		}

		//lưu order vào csdl
		is.save(itemDAO);
		model.addFlashAttribute("message", "Cập nhật đơn hàng thành công.");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/order/finished";
	}
	@RequestMapping(value="saveItemCancel",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemCancel(@Valid @ModelAttribute ItemDAO itemDAO,
								   BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
								   RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			return "backend/order/cancel";
		}

		if(itemDAO.getItemStatus().equals("Cho xu ly")){
		//lưu order vào csdl
		is.saveItem(itemDAO);
		model.addFlashAttribute("message", "恢复订单成功.");
		model.addAttribute("loginUser", us.currentLoginUser());
			model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/order/cancel";}

		Item item = itemDAO.convertToEntity();
		is.remove(item);
		model.addFlashAttribute("message", "取消成功 .");
		model.addAttribute("loginUser", us.currentLoginUser());

		return "redirect:/backend/order/cancel";
	}
	@RequestMapping(value="saveItemFix",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemFix(@Valid @ModelAttribute ItemDAO itemDAO,
								   BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
								   RedirectAttributes model)  throws Exception {

			if(!itemDAO.getAdminNote().equals("")){
				if (bindingResult.hasErrors()) {
					return "backend/order/complain";
				}
				//lưu order vào csdl
				is.save(itemDAO);
				model.addFlashAttribute("message", "订单更新成功.");
				model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

				return "redirect:/backend/order/complain";
			}

		if (bindingResult.hasErrors()) {
			return "backend/order/fix";
		}

		//lưu order vào csdl
		is.save(itemDAO);
		model.addFlashAttribute("message", "订单更新成功.");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/order/fix";
	}

	@RequestMapping(value="saveItemMerged",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveItemMerged(@Valid @ModelAttribute ItemDAO itemDAO,
								 BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
								 RedirectAttributes model)  throws Exception {

		if (bindingResult.hasErrors()) {
			return "/backend/item/mergedList";
		}

		//lưu order vào csdl
		is.save(itemDAO);
		model.addFlashAttribute("message", "Cập nhật đơn hàng thành công.");
		model.addAttribute("loginUser", us.currentLoginUser());
		model.addAttribute("countCartItemAdmin", is.countCartItemAdmin());

		return "redirect:/backend/item/mergedList";
	}

}
