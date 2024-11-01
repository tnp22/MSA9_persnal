package shop.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * @return
	 */
	public List<Product> list() {
		// 게시글 목록을 담을 컬렉션 객체 생성
				List<Product> pdList = new ArrayList<Product>();

				// SQL 작성
				String sql = "SELECT * " 
						+ " FROM product";

				try(Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql);) {
					// 1. SQL 실행 객체 생성 - Statement (stmt)
					
					// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
					
					// 3. 조회된 결과를 리스트(boardList)에 추가
					while (rs.next()) {
						Product pd = new Product();
						// 결과 데이터 가져오기
						// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
						pd.setProductId(rs.getString("product_id"));
						pd.setName(rs.getString("name"));
						pd.setUnitPrice(rs.getInt("unit_price"));
						pd.setDescription(rs.getString("description"));
						pd.setManufacturer(rs.getString("manufacturer"));
						pd.setCategory(rs.getString("category"));
						pd.setUnitsInStock(rs.getInt("units_in_stock"));
						pd.setCondition(rs.getString("condition"));
						pd.setFile(rs.getString("file"));
						// 게시글 목록 추가
						pdList.add(pd);
					}
					// 4. 게시글 목록 반환

				} catch (SQLException e) {
					System.err.println("productDAO : list 예외발생");
					e.printStackTrace();
				}
				return pdList;
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Product> pdList = new ArrayList<Product>();
		
		// SQL 작성
		String sql = "SELECT * " 
				+ " FROM product"
				+ " WHERE name LIKE ? or description LIKE ? or manufacturer LIKE ?"
				+ " or category LIKE ?";

		try(PreparedStatement psmt = con.prepareStatement(sql)) {
			String searchKeyword = "%" + keyword + "%";
			psmt.setString(1, searchKeyword);
			psmt.setString(2, searchKeyword);
			psmt.setString(3, searchKeyword);
			psmt.setString(4, searchKeyword);
			ResultSet rs=psmt.executeQuery();
			// 1. SQL 실행 객체 생성 - Statement (stmt)
			
			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
			
			// 3. 조회된 결과를 리스트(boardList)에 추가
			while (rs.next()) {
				Product pd = new Product();
				// 결과 데이터 가져오기
				// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
				pd.setProductId(rs.getString("product_id"));
				pd.setName(rs.getString("name"));
				pd.setUnitPrice(rs.getInt("unit_price"));
				pd.setDescription(rs.getString("description"));
				pd.setManufacturer(rs.getString("manufacturer"));
				pd.setCategory(rs.getString("category"));
				pd.setUnitsInStock(rs.getInt("units_in_stock"));
				pd.setCondition(rs.getString("condition"));
				pd.setFile(rs.getString("file"));
				// 게시글 목록 추가
				pdList.add(pd);
			}
			// 4. 게시글 목록 반환

		} catch (SQLException e) {
			System.err.println("productDAO : list 검색 예외발생");
			e.printStackTrace();
		}
		return pdList;
	}
	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		String sql="SELECT * "
				+ " FROM product"
				+ " WHERE product_id = ?";
		Product pd = null;
		try(PreparedStatement psmt = con.prepareStatement(sql);) {
			psmt.setString(1, productId);
			try(ResultSet rs=psmt.executeQuery()){
				if(rs.next()) {
					pd = new Product(); // Product 객체 초기화
					pd.setProductId(rs.getString("product_id"));
					pd.setName(rs.getString("name"));
					pd.setUnitPrice(rs.getInt("unit_price"));
					pd.setDescription(rs.getString("description"));
					pd.setManufacturer(rs.getString("manufacturer"));
					pd.setCategory(rs.getString("category"));
					pd.setUnitsInStock(rs.getInt("units_in_stock"));
					pd.setCondition(rs.getString("condition"));
					pd.setFile(rs.getString("file"));
				}
			}
		} catch (Exception e) {
			System.err.println("productDAO : 제품 번호로 조회 시 예외 발생");
		}
		return pd;
	}
	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		
		String sql = " INSERT INTO product(product_id,name,unit_price,"
				+ "description,manufacturer,category,units_in_stock,`condition`,file)"
				+ " VALUES( ?,?,?,?,?,?,?,?,?)";
		
		try(PreparedStatement psmt = con.prepareStatement(sql);) {
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());			
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("productDAO : insert 시,예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
		String sql="UPDATE product"
				+ " set name = ?,"
				+ " unit_price = ?,"
				+ " description = ?,"
				+ " manufacturer = ?,"
				+ " category = ?,"
				+ " units_in_stock = ?,"
				+ " `condition` = ?,"
				+ " file = ?"
				+ " WHERE product_id = ?";
		try(PreparedStatement psmt = con.prepareStatement(sql);) {
			psmt.setString(1,product.getName());
			psmt.setInt(2,product.getUnitPrice());
			psmt.setString(3,product.getDescription());
			psmt.setString(4,product.getManufacturer());
			psmt.setString(5,product.getCategory());
			psmt.setLong(6,product.getUnitsInStock());			
			psmt.setString(7,product.getCondition());
			psmt.setString(8,product.getFile());
			psmt.setString(9,product.getProductId());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("productDAO :  update 시 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		int result = 0;
		String sql="DELETE "
				+ " FROM product"
				+ " WHERE product_id = ?";
		try (PreparedStatement psmt = con.prepareStatement(sql);){
			psmt.setString(1, productId);
			result = psmt.executeUpdate() == 0 ? 0:1;
		} catch (Exception e) {
			System.err.println("productDAO : delete시 예외 발생");
		}
		return result;
	}

}





























