package com.mrChill.Relax.entities;

import java.util.ArrayList;
import java.util.List;

public class MergedList {

	public List<Item> items;
	public MergedList() {
		items = new ArrayList<>();
	}

	// merge a new item to MergedList
	public void merged(Item ci) {
		items.add(ci);
	}

	// remove a Item in MergedList
	public void remove(int item_id) {
		for (Item x : items) {
			if (x.getItemId() == item_id) {
				items.remove(x);
				return;
			}
		}
	}
	public List<Item> getItems() {
		return items;
	}

	public void setItems(List<Item> items) {
		this.items = items;
	}


}
