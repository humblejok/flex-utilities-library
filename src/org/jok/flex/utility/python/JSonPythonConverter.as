package org.jok.flex.utility.python
{
	import mx.controls.DateField;
	import mx.formatters.DateFormatter;
	import mx.utils.StringUtil;

	public class JSonPythonConverter {
		
		private var httpDateFormatter : DateFormatter = new DateFormatter();
		
		public function JSonPythonConverter() {
			httpDateFormatter.formatString="YYYY-MM-DD";
		}
		
		public function convertDateToActionScript(object : Object) : Date {
			if (object==null) {
				return null;
			}
			var fullDate : String = object["py/repr"].toString().substring(23,object["py/repr"].toString().length-1);
			var splitDate : Array = fullDate.split(/,/);
			return new Date(Number(splitDate[0]),Number(splitDate[1])-1,Number(splitDate[2]));
		}
		
		public function convertDateToJSon(date : Date) : Object {
			var fullDate : String = "datetime/datetime.date(" + date.getFullYear() + ", " + (date.getMonth()+1) + ", " + date.getDate() +")"
			var result : Object = new Object();
			result["py/repr"] = fullDate;
			return result;
		}
		
		public function convertNumberToActionScript(object : Object) : Number {
			if (object==null) {
				return NaN;
			}
			var numberFormat : String = object["py/object"];
			var sign : Number = object["_sign"]==0?1:-1;
			var exp : Number = object["_exp"];
			var value : Number = Number(object["_int"]);
			return (value * Math.pow(10,exp) * sign).valueOf();
		}
		
		public function convertJSonDateToHTTPRequestDate(object : Object) : String {
			if (object==null) {
				return "";
			}
			return httpDateFormatter.format(convertDateToActionScript(object));
		}
		
		public function convertHTTPRequestDateToDate(date : String) : Date {
			if (date==null) {
				return new Date();
			}
			return DateField.stringToDate(date,"YYYY-MM-DD");
		}
		
	}
}