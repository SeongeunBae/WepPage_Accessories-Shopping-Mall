<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="my.model.*,my.dao.*,my.util.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="mainlayout.css" rel="stylesheet" type="text/css" />
<link href="SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<script src="SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
    <script>
      $( document ).ready( function() {
        var jbOffset = $( '#page_header' ).offset();
        $( window ).scroll( function() {
          if ( $( document ).scrollTop() > jbOffset.top ) {
            $( '#page_header' ).addClass( 'jbFixed' );
          }
          else {
            $( '#page_header' ).removeClass( 'jbFixed' );
          }
        });
      } );
      </script>
      
</head>
<body>
<div id="wrap">
  <div id="page_header">
    <div id="top_content">
     <div id="Tmenu">
 <% 
     String Id = (String)session.getAttribute("UI");
     if(Id != null){
    	 %>
    	 <a href="logout.jsp"><img src="images/loginsss_03.gif" width="61" height="36" /></a>
    	 
    	 <%
     }else{
   	 %> 
   <a href="loginform.jsp"><img src="images/lloyd_05.gif" width="61" height="36" /></a>
     
          <%
          } %>
     <a href="memberApp.jsp"><img src="images/lloyd_06.gif" width="70" height="36" /></a>
    <%
     if(Id != null){
    	 %>
    	 <a href="cart.jsp"><img src="images/lloyd_07.gif" width="70" height="36" /></a>
    	 <%
     }
    	 %>
    	 <%
    	 if(Id == null){
    	 %>
    	 <a href="loginform.jsp"><img src="images/lloyd_07.gif" width="70" height="36" /></a>
    	 <%
     }
    	 %>
    	 <%
     if(Id != null){
    	 %>
    	 <a href="mp.jsp"><img src="images/lloyd_08.gif" width="80" height="36" /></a>
    	 <%
     }
    	 %>
    	 <%
    	 if(Id == null){
    	 %>
    	 <a href="loginform.jsp"><img src="images/lloyd_08.gif" width="80" height="36" /></a>
    	 <%
     }
    	 %>
      <a href="qna.jsp"><img src="images/lloyd_093.gif" width="57" height="36" /></a> </div>
     
    
      <div id="logo"><a href="main.jsp"><img src="images/logo1.gif"/></a></div>
      <div id="serchbox">
        <form id="form1" name="form1" method="post" action="search.jsp">
        <select name="keyfield">
                  		<option value="productName">상품명</option>
                  	</select>
          <input name="searchbox" type="text" id="searchbox" size="15" />
          <input type="image" name="search" id="search" onclick="searchForm(form); return false;"  
        	  value= "img" src ="images/lloyd2_03.gif"/>  
        </form>
      </div>
    </div>
    
    <div id="pannel">
      <div id="pannel_content">
        <ul id="MenuBar1" class="MenuBarHorizontal">
          <li><a href="new.jsp">NEW</a></li>
          <li><a href="best.jsp">BEST</a></li>
          <li><a class="MenuBarItemSubmenu" href="ex4.jsp?pdkind=WATCH">WATCH</a>
            <ul>
              <li><a href="ex3.jsp?pdDkind=METAL">METAL</a></li>
              <li><a href="ex3.jsp?pdDkind=LEATHER">LEATHER</a></li>
            </ul>
          </li>
          <li><a href="ex4.jsp?pdkind=NECKLACE" class="MenuBarItemSubmenu">NECKLACE</a>
            <ul>
              <li><a href="ex3.jsp?pdDkind=CHAIN">CHAIN</a></li>
              <li><a href="ex3.jsp?pdDkind=PENDANT">PENDANT</a></li>
            </ul>
          </li>
          <li><a href="ex4.jsp?pdkind=EARRING" class="MenuBarItemSubmenu">EARRING</a>
            <ul>
              <li><a href="ex3.jsp?pdDkind=ONETOUCH">ONETOUCH</a></li>
              <li><a href="ex3.jsp?pdDkind=PIERCING">PIERCING</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
    </div>

  <div id ="page_main">
 <%
	String uploadPath = "C:\\Wep\\teampro\\WebContent\\teampro2\\itemimage";
	int maxSize = 1024 * 1024 * 100; // 한번에 올릴 수 있는 파일 용량 : 100M로 제한
	MultipartRequest multi = null;
    multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());     
    String pdKind = multi.getParameter("pdKind");
    String pdDkind = multi.getParameter("pdDkind");
    String productName = multi.getParameter("productName");
    
    String pr = multi.getParameter("price");
    String re = multi.getParameter("reserve");
    String makeCountry = multi.getParameter("makeCountry");
    String optionName1 = multi.getParameter("optionName1");
    String optionName2 = multi.getParameter("optionName2");
    String optionName3 = multi.getParameter("optionName3");
    String optionValue1 = multi.getParameter("optionValue1");
    String optionValue2 = multi.getParameter("optionValue2");
    String optionValue3 = multi.getParameter("optionValue3");
    String smallImage= multi.getOriginalFileName("smallImage");
    String bigImage = multi.getOriginalFileName("bigImage");
    String detailImage1 = multi.getOriginalFileName("detailImage1");
    String detailImage2 = multi.getOriginalFileName("detailImage2");
%>
<% 
  if (productName.equals("")==true) {
      %>
       <script type="text/javascript">
      alert("상품명을 입력해주세요.");
      history.go(-1);
   </script>
      <% 
  }
  else if(pr.equals("")==true){
	  %>
	  <script type="text/javascript">
      alert("가격을 입력해주세요.");
      history.go(-1);
   </script>
   <%
  }
  else if(re.equals("")==true){
	  %>
	  <script type="text/javascript">
      alert("적립금을 입력해주세요.");
      history.go(-1);
   </script>
   <%
  }
  else if(makeCountry.equals("")==true){
	  %>
	  <script type="text/javascript">
      alert("제조국을 입력해주세요.");
      history.go(-1);
   </script>
    <%
  }
  else if(smallImage==null){
	  %>
	  <script type="text/javascript">
      alert("작은 이미지을 등록해주세요.");
      history.go(-1);
   </script>
    <%
  }
  else if(bigImage==null){
	  %>
	  <script type="text/javascript">
      alert("큰 이미지을 등록해주세요.");
      history.go(-1);
   </script>
    <%
  }
  else if(detailImage1==null){
	  %>
	  <script type="text/javascript">
      alert("디테일 이미지을 등록해주세요.");
      history.go(-1);
   </script>
    <%
  }
  else {
	  int price = Integer.parseInt(pr);
	  int reserve = Integer.parseInt(re);
	  Product product = new Product(pdKind,pdDkind,productName,price,reserve,makeCountry,optionName1,optionName2,optionName3,optionValue1,optionValue2,optionValue3,smallImage,bigImage,detailImage1,detailImage2,new java.util.Date());
	    Connection conn = ConnectionProvider.getConnection();
	    try {
	    	ProductDao dao = new ProductDao();
	    	dao.insert(conn, product);
	    }catch(SQLException e){ 
	    	
	    }
	    finally {
			JdbcUtil.close(conn);
	    }
	    
  }
  %>




<p align="center">

상품종류 : <%= pdKind %><br>
상세분류선택 : <%= pdDkind %><br>
상품명 : <%= productName %><br>
판매가 : <%= pr %><br> 
적립금 : <%= re %><br>
제조국 : <%= makeCountry %><br>
옵션명1 : <%= optionName1%><br>
옵션명2 : <%= optionName2%><br>
옵션명3 : <%= optionName3%><br>
옵션값1 : <%= optionValue1%><br>
옵션값2 :<%= optionValue2%><br>
옵션값3 :<%= optionValue3%><br>
작은 이미지 : <%= smallImage%><br>
큰 이미지 : <%= bigImage%><br>
제품 상세이미지 1 : <%= detailImage1%><br>
제품 상세이미지 2 : <%= detailImage2%><br>
</p>


  
  </div>
  <div id="page_footer"> 
    <div id="companyinfo"><img src="images/DQWED_03.gif" width="390" height="125" /></div>
    <div id="bankinfo"><img src="images/DQWED_10.gif" width="170" height="125" /></div>
    <div id="callcenter"><img src="images/DQWED_13.gif" width="170" height="114" /></div>
    <div id="delivery"><img src="images/DQWED_06.gif" width="148" height="57" /></div>
   
  </div>
  </div>
  <script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"SpryAssets/SpryMenuBarDownHover.gif", imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
</script>

</body>
</html>