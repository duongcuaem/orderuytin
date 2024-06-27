package com.mrChill.Relax.Repository.shop;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mrChill.Relax.entities.shop.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
