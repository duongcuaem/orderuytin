package com.mrChill.Relax.Controller.USERs;

import com.mrChill.Relax.Dao.ItemDAO;
import com.mrChill.Relax.Service.ItemService;
import com.mrChill.Relax.Service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;


@RestController
public class addItemCartController {
    @Autowired
    ItemService is;

    @Autowired
    UsersService us;

    @PostMapping(value="/addItemToCart",consumes = {"application/json"})
    public RedirectView addCart(@RequestBody  ItemDAO itemDAO)
            throws Exception {
        itemDAO.setItemUserName(us.searchByPhone(itemDAO.itemUserName).getUserName());
        is.saveItem(itemDAO);
        return new RedirectView(itemDAO.link);
    }

}
