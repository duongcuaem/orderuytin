package com.mrChill.Relax.Service;

import com.mrChill.Relax.Repository.MeregedListRepository;
import com.mrChill.Relax.entities.Item;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;
import java.util.*;

@Service
@SessionScope
public class MergedListService implements MeregedListRepository {
      Map<Integer, Item> maps = new HashMap<>();

    public void merged(Item item){
        maps.put(item.getItemId(),item);
    }

    public Collection<Item> getAllItem(){
          return maps.values();
    }
    public void reset() {
        maps = new HashMap();
    }
    public  void remove (int itemId){
        maps.remove(itemId);
    }

}
