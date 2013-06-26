package org.jok.flex.utility.number
{
	import mx.formatters.NumberFormatter;
	
	public class NumberFormatter extends mx.formatters.NumberFormatter {
		
		public var removeTrailingZeros : Boolean = false;
		
		public function NumberFormatter() {
			super();
		}
		
		override public function format(value : Object) : String {
			var result : String = "-";
			if (!isNaN(Number(value))) {
				result = super.format(value);
				if (removeTrailingZeros && precision!=0 && result.indexOf(decimalSeparatorTo)>=0) {
					while (result.charAt(result.length-1)=="0" || result.charAt(result.length-1)==decimalSeparatorTo) {
						if (result.charAt(result.length-1)==decimalSeparatorTo) {
							return result.substring(0,result.length-1);
						}
						result = result.substring(0,result.length-1);
					}
				}
			}
			return result;
		}
	}
}