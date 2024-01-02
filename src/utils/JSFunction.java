package utils;

import javax.servlet.jsp.JspWriter;

public class JSFunction {
	// 메시지 알림창을 띄운 후 명시한 URL로 이동한다.
	public static void alertLocation(String msg, String url, JspWriter out) {
		try {
			String script = "<script>alert('" + msg + "');"
							+ "location.href='" + url + "';" + "</script>";
			
			out.println(script);
		} catch(Exception e) {
			
		}
	}
	
	// 메시지 알림창을 띄운 후 이전 페이지로 돌아가기
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = "<script>alert('" + msg + "');"
							+ "history.back();" + "</script>";
			
			out.println(script);
		} catch(Exception e) {
			
		}
	}
	
	// 선택창을 띄운 후 확인 시 명시한 URL로 이동하고, 취소 시 이전 페이지로 돌아가기
	public static void confirmBack(String msg, String trueUrl, JspWriter out) {
		try {
			String script = "<script>"
					+ "if (confirm('" + msg + "')) {"
					+ "location.href='" + trueUrl + "';"
					+ "} else {"
					+ "history.back();"
					+ "}"
					+ "</script>";

			out.println(script);
		} catch(Exception e) {
			
		}
	}
	
}
