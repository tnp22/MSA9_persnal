<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
DiskFileUpload upload = new DiskFileUpload();
/* String path = application.getRealPath("/userImg"); // 실제 경로 확인 */
String path = "C:\\UPLOAD";
/* String path = application.getRealPath("/webapp/static/fimg"); */

upload.setSizeMax(10 * 1000 * 1000); // 10MB - 파일 최대 크기
upload.setSizeThreshold(4 * 1024); // 4MB - 메모리상의 최대 크기

List<FileItem> items = upload.parseRequest(request);
Iterator<FileItem> params = items.iterator();

ProductRepository priy = new ProductRepository();
Product pd = new Product();


String productId= "";
String Name= "";
Integer unitPrice = 0;
String description= "";
String manufacturer= "";
String category= "";
String condition= "";
long unitsInStock = 0;



while (params.hasNext()) {
	FileItem item = params.next();

	// 일반 데이터
	if (item.isFormField()) {
		String name = item.getFieldName();
		String value = item.getString("utf-8");

	if (name.equals("productId")) {
		productId = value;
		} else if (name.equals("name")) {
			Name = value;
		} else if (name.equals("unitPrice")) {
			unitPrice = Integer.parseInt(value);
		} else if (name.equals("description")) {
			description = value;
		} else if (name.equals("manufacturer")) {
			manufacturer = value;
		}
		else if (name.equals("category")) {
			category = value;
		}
		else if (name.equals("condition")) {
			condition = value;
		}
		else if (name.equals("unitsInStock")) {
			unitsInStock = Integer.parseInt(value);
		}
	}
	// 파일 데이터
	else {
		String fileName = item.getName();
		fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

		// 경로 확인 및 디렉토리 생성
		File dir = new File(path);
		if (!dir.exists()) {
	boolean created = dir.mkdirs();
	if (!created) {
		out.println("디렉토리 생성 실패: " + path);
		return; // 오류 발생 시 종료
	}
		}

		File file = new File(dir, fileName);
		/*         fff.setFile_path("userImg/" + fileName); // DB에 저장할 경로 */
		pd.setFile(path + "/" + fileName);
		try {
	item.write(file); // 파일 저장
		} catch (Exception e) {
	out.println("파일 저장 실패: " + e.getMessage());
	return; // 오류 발생 시 종료
		}
	}
}

pd.setProductId(productId);
pd.setName(Name);
pd.setUnitPrice(unitPrice);
pd.setDescription(description);
pd.setManufacturer(manufacturer);
pd.setCategory(category);
pd.setCondition(condition);
pd.setUnitsInStock(unitsInStock);

priy.insert(pd);


response.sendRedirect("products.jsp");

%>