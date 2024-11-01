package shop.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		
		String sql = " INSERT INTO product_io(product_id,"
				+ "order_no, amount, type,"
				+ "user_id)"
				+ " VALUES( ?,?,?,?,?,?)";
		
		try(PreparedStatement psmt = con.prepareStatement(sql);) {
			psmt.setString(1, product.getProductId());
			psmt.setInt(2, product.getOrderNo());
			psmt.setLong(3, product.getUnitsInStock());
			psmt.setString(4, product.getType());	
			psmt.setString(5, product.getUserId());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("productDAO : insert 시,예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	

}