package com.mrChill.Relax.Controller.ADMIN;

import com.mrChill.Relax.Repository.ItemRepository;
import com.mrChill.Relax.Service.ItemService;
import com.mrChill.Relax.Service.MergedListService;
import com.mrChill.Relax.Service.OrdersService;
import com.mrChill.Relax.Service.UsersService;
import com.mrChill.Relax.entities.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServlet;
import java.util.Collection;

@Controller
@RequestMapping("/backend/item")
public class MergedController extends HttpServlet {
	@Autowired
	ItemService is;

	@Autowired
	MergedListService ms;

	@Autowired
	ItemRepository ir;

	@Autowired
	UsersService us;

	@Autowired
	OrdersService os;

	@GetMapping("mergedList")
	public String mergedList (Model model){
		model.addAttribute("mergedList",ms.getAllItem());
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
		return "/backend/item/mergedList";
	}
	@GetMapping("merg/{itemId}")
	public String merg(RedirectAttributes model, @PathVariable("itemId") Integer itemId) throws Exception{
		Item item = is.findByItemId(itemId);
		Collection<Item> listItem = ms.getAllItem();
		for(Item i : listItem){
			if(!item.getItemUserName().equals(i.getItemUserName())){
				model.addFlashAttribute("message", "不可能合并不一样的两个名字客户的两个单");
				return "redirect:/backend/order/pending";}
		}
		ms.merged(item);
		item.setItemStatus("已合并");
		ir.save(item);
		return "redirect:/backend/order/pending";
	}

	@GetMapping("remove/{itemId}")
	public String remove(@PathVariable("itemId") Integer itemId) {
		Item item = is.findByItemId(itemId);
		ms.remove(itemId);
		item.setItemStatus("Cho xu ly");
		ir.save(item);
		return "redirect:/backend/item/mergedList";
	}
	}
