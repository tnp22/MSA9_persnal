package shop.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		
		String sql = " INSERT INTO `order`(ship_name,zip_code,country,"
				+ "address,date,order_pw,user_id,phone)"
				+ " VALUES( ?,?,?,?,?,?,?,?)";
		
		try(PreparedStatement psmt = con.prepareStatement(sql);) {
			psmt.setString(1, order.getShipName());
			psmt.setString(2, order.getZipCode());
			psmt.setString(3, order.getCountry());
			psmt.setString(4, order.getAddress());
			psmt.setString(5, order.getDate());			
			psmt.setString(6, order.getOrderPw());
			psmt.setString(7, order.getUserId());
			psmt.setString(8, order.getPhone());			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("orderDAO : insert 시,예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int insertedId=0;
		String sql = "SELECT LAST_INSERT_ID();";
		try (Statement stmt = con.createStatement()) {
			rs = stmt.executeQuery("SELECT LAST_INSERT_ID();");
			if (rs.next()) {
	            insertedId = rs.getInt(1);
	        }
		} catch (SQLException e) {
			System.err.println("orderDAO : lastOrderNo 시,예외 발생");
			e.printStackTrace();
		}
		return insertedId;
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Product> pdList = new ArrayList<Product>();
		
		// SQL 작성
		String sql = " SELECT product.*, product_io.* "
				+ " FROM product "
				+ " INNER JOIN `product_io` on product.product_id = `product_io`.`product_id` "
				+ "	where(product_io.order_no = (SELECT `order`.order_no " 
				+ " FROM `order` "
				+ " where user_id = ?))";
		try(PreparedStatement psmt = con.prepareStatement(sql);) {
			psmt.setString(1, userId);
			try(ResultSet rs = psmt.executeQuery();){
				// 3. 조회된 결과를 리스트(boardList)에 추가
				while (rs.next()) {
					Product pd = new Product();
					// 결과 데이터 가져오기
					// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
					pd.setOrderNo(rs.getInt("order_no"));
					pd.setName(rs.getString("name"));
					pd.setUnitPrice(rs.getInt("unit_price"));
					pd.setCondition(rs.getString("condition"));
					pd.setQuantity(rs.getInt("amount"));
					// 게시글 목록 추가
					pdList.add(pd);
				}
			} 
		} catch (SQLException e) {
			System.err.println("productDAO : list 검색 예외발생");
			e.printStackTrace();
		}
		return pdList;
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Product> pdList = new ArrayList<Product>();
		
		// SQL 작성
		String sql = " SELECT product.*, product_io.* "
				+ " FROM product "
				+ " INNER JOIN `product_io` on product.product_id = `product_io`.`product_id` "
				+ "	where(product_io.order_no = (SELECT `order`.order_no " 
				+ " FROM `order` "
				+ " where phone = ? and order_pw = ?))";
			
		if (con == null) {
	        System.err.println("데이터베이스 연결이 null입니다.");
	        return pdList; // 빈 리스트 반환
	    }
		
		try{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, phone);
			psmt.setString(2, orderPw);			
			ResultSet rs = psmt.executeQuery();
				// 3. 조회된 결과를 리스트(boardList)에 추가
				while (rs.next()) {
					Product pd = new Product();
					// 결과 데이터 가져오기
					// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
					pd.setOrderNo(rs.getInt("order_no"));
					pd.setName(rs.getString("name"));
					pd.setUnitPrice(rs.getInt("unit_price"));
					pd.setCondition(rs.getString("condition"));
					pd.setQuantity(rs.getInt("amount"));
					// 게시글 목록 추가
					pdList.add(pd);
				}
		} catch (SQLException e) {
			System.err.println("productDAO : list 검색 예외발생");
			e.printStackTrace();
		}
		return pdList;
	}
	
}






