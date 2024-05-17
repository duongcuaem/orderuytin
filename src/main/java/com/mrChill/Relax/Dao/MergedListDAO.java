package com.mrChill.Relax.Dao;

import com.mrChill.Relax.context.ConnectSQLServer;
import com.mrChill.Relax.entities.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MergedListDAO {
    public Item getItem(int id) throws Exception {
        Item i = null;
        String sql = "SELECT * FROM item WHERE itemId = ? ";

        Connection conn = ConnectSQLServer.getConnection();
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, id);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            Integer itemId = resultSet.getInt("itemId");
            int quantity = resultSet.getInt("quantity");
            int orderId = resultSet.getInt("orderId");
            String userName = resultSet.getString("userName");
            String describle = resultSet.getString("describle");
            String image = resultSet.getString("image");
            String status = resultSet.getString("status");
            float price = resultSet.getFloat("price");

            i = new Item(itemId,quantity, orderId, image,userName,
                  describle, status,price);
        }

        resultSet.close();
        statement.close();

        return i;
    }
}
